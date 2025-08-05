const express = require('express');
const path = require('path');
const fs = require('fs');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const port = 3000;

// Backend service URL (Kubernetes internal DNS)
const BACKEND_URL = process.env.BACKEND_URL || 'http://backend:5000';

// Parse form data
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'static')));

// Proxy API requests to the backend
app.use('/api', createProxyMiddleware({
  target: BACKEND_URL,
  changeOrigin: true,
  pathRewrite: { '^/api': '' },
}));

// Serve the main index.html
app.get('/', (req, res) => {
  fs.readFile(path.join(__dirname, 'templates', 'index.html'), 'utf8', (err, html) => {
    if (err) {
      res.status(500).send('Error loading page');
    } else {
      res.send(html);
    }
  });
});

// Serve the success page after redirect
app.get('/submit-success', (req, res) => {
  res.sendFile(path.join(__dirname, 'templates', 'success.html'));
});

// Start the server
app.listen(port, () => {
  console.log(`✅ Frontend running at http://localhost:${port}`);
  console.log(`🔁 Proxying API requests to: ${BACKEND_URL}`);
});
