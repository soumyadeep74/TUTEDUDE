const express = require('express');
const path = require('path');
const fs = require('fs');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const port = 3000;

// Use environment variable or fallback
const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:5000';

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'static')));

// Proxy all API requests to the backend
app.use('/api', createProxyMiddleware({
  target: BACKEND_URL,
  changeOrigin: true,
  pathRewrite: { '^/api': '' },
}));

// Serve index.html with placeholder __BACKEND_URL__ removed (optional)
app.get('/', (req, res) => {
  fs.readFile(path.join(__dirname, 'templates', 'index.html'), 'utf8', (err, html) => {
    if (err) {
      res.status(500).send('Error loading page');
    } else {
      // Optional: Replace placeholder or leave as-is if not needed
      const modifiedHtml = html.replace('__BACKEND_URL__', '');
      res.send(modifiedHtml);
    }
  });
});

// Start the frontend server
app.listen(port, () => {
  console.log(`✅ Frontend running at http://localhost:${port}`);
  console.log(`🔁 Proxying API requests to: ${BACKEND_URL}`);
});
