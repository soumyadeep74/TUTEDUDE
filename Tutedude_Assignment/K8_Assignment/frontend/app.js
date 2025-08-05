const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const port = 3000;

// ENV variable fallback (for flexibility)
const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:5000';

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'static')));

// Serve the main HTML file with backend URL injected
app.get('/', (req, res) => {
  fs.readFile(path.join(__dirname, 'templates', 'index.html'), 'utf8', (err, html) => {
    if (err) {
      res.status(500).send('Error loading page');
    } else {
      // Inject the backend URL
      const modifiedHtml = html.replace('__BACKEND_URL__', BACKEND_URL);
      res.send(modifiedHtml);
    }
  });
});

app.listen(port, () => {
  console.log(`Frontend running at http://localhost:${port}`);
  console.log(`Using backend URL: ${BACKEND_URL}`);
});
