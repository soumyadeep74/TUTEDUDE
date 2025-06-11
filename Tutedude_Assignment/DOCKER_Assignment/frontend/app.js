const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const axios = require('axios');
const querystring = require('querystring'); // for encoding form data

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'templates')));

app.post('/submit', async (req, res) => {
    try {
        // Encode req.body as application/x-www-form-urlencoded
        const formData = querystring.stringify(req.body);

        await axios.post('http://localhost:5000/submit', formData, {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        });

        res.send('Data submitted to backend!');
    } catch (err) {
        console.error('Error submitting data:', err.message);
        res.status(500).send('Failed to submit data to backend.');
    }
});

app.listen(port, () => {
    console.log(`Frontend running at http://localhost:${port}`);
});
