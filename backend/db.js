const { Pool } = require('pg');

const pool = new Pool ({
    user: 'user',
    host: 'db',
    database: 'mydb',
    password: 'pass',
    port: 5432,
});

pool.on('coonect', () => {
    console.log('Connected to the database');
});

module.exports = pool;