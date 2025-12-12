const express = require('express');
const cors = require('cors');
const pool = require('./db'); //importe la conneion à la base de données
const app = express();
app.use(cors());
app.use(express.json());

app.get('/health/db', async (req, res) => {
    try {
        const result = await pool.query('SELECT NOW()');
        res.json({ success: true, time: result.rows[0].now });
    } catch (err) {
        console.error(err);
        res.status(500).json({ success: false, error: 'Database connection error' });
    }
});

app.get('/jobs', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM jobs');
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ success: false, error: 'Failed to fetch jobs' });
    }
});

app.listen(5000, () => console.log('Backend running on port 5000'));