const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'templates')));

app.post('/submit', (req, res) => {
    // Redirect the POST request to the Flask backend
    res.redirect(307, 'http://localhost:5000/submit');
});

app.listen(port, () => {
    console.log(`Frontend running at http://localhost:${port}`);
});
