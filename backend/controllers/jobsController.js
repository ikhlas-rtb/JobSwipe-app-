const pool = require('../db');

exports.list = async (req, res, next) => {
  try {
    const { page = 1, limit = 20, q, skills } = req.query;
    const pageNum = Math.max(1, Number(page) || 1);
    const maxLimit = 100;
    const limitNum = Math.min(maxLimit, Number(limit) || 20);
    const offset = (pageNum - 1) * limitNum;

    let baseQuery = 'SELECT *, COUNT(*) OVER() AS total_count FROM jobs';
    const clauses = [];
    const params = [];

    if (q) {
      params.push(`%${q}%`);
      clauses.push(`(title ILIKE $${params.length}::text OR description ILIKE $${params.length}::text)`);
    }


    if (skills) {
      const skillList = String(skills)
        .split(',')
        .map(s => s.trim())
        .filter(Boolean);

      if (skillList.length) {
        // For each requested skill name require the job to be linked to that skill via job_skills -> skills
        for (const skill of skillList) {
          params.push(skill.toLowerCase());
          // use EXISTS subquery to avoid changing SELECT/GROUP BY structure
          clauses.push(`EXISTS (
            SELECT 1 FROM job_skills js
            JOIN skills s ON s.id = js.skill_id
            WHERE js.job_id = jobs.id AND lower(s.name) = $${params.length}::text
          )`);
        }
      }
    }

    if (clauses.length > 0) {
      baseQuery += ' WHERE ' + clauses.join(' AND ');
    }

    params.push(limitNum);
    params.push(offset);
    baseQuery += ` ORDER BY created_at DESC LIMIT $${params.length - 1}::int OFFSET $${params.length}::int`;

    const result = await pool.query(baseQuery, params);
    const rows = result.rows || [];
    const totalCount = rows.length ? Number(rows[0].total_count) : 0;

    res.json({
      page: pageNum,
      limit: limitNum,
      count: rows.length,
      total: totalCount,
      jobs: rows.map(r => {
        const { total_count, ...job } = r;
        return job;
      }),
    });
  } catch (err) {
    next(err);
  }
};