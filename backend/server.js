const express = require('express');
const cors = require('cors');
const pool = require('./db'); //importe la connexion à la base de données
const app = express();
app.use(cors());
app.use(express.json());

//health check endpoint
app.get('/health/db', async (req, res) => {
    try {
        const result = await pool.query('SELECT NOW()');
        res.json({ success: true, time: result.rows[0].now });
    } catch (err) {
        console.error(err);
        res.status(500).json({ success: false, error: 'Database connection error' });
    }
});


//routes 
const jobsRouter = require('./routes/jobs');
app.use('/jobs', jobsRouter);

//central error handler
const errorHandler = require('./middlewares/errorHandlers');
app.use(errorHandler);


app.listen(process.env.PORT || 5000, () => console.log('Backend running on port', process.env.PORT || 5000));