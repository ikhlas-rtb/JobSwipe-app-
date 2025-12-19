const { Pool } = require('pg');

const pool = new Pool ({
    user: process.env.PG_USER ||'user',
    host: process.env.PG_HOST || 'db',
    database: process.env.PG_DATABASE || 'mydb',
    password: process.env.PG_PASSWORD || 'pass',
    port:   Number(process.env.PG_PORT) || 5432,
    max: 20,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 2000,
});

pool.on('connect', () => {
    console.log('Connected to the database');
});

pool.on('error', (err) => {
    console.error('Unexpected error on idle client', err);
});

module.exports = pool;