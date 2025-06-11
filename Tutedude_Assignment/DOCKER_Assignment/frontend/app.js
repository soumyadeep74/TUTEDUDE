const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const axios = require('axios');

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'templates')));

app.post('/submit', async (req, res) => {
    try {
        await axios.post('http://backend:5000/submit', req.body);
        res.send('Data submitted to backend!');
    } catch (err) {
        res.status(500).send('Failed to submit data to backend.');
    }
});

app.listen(port, () => {
    console.log(`Frontend running at http://localhost:${port}`);
});
