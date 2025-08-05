const express = require('express');
const path = require('path');
const fs = require('fs');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const port = process.env.PORT || 3000;

// Use env var or fallback to localhost
const BACKEND_URL = process.env.BACKEND_URL || 'http://api.local:5000';

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'static')));

// Proxy /api to backend
app.use('/api', createProxyMiddleware({
  target: BACKEND_URL,
  changeOrigin: true,
  pathRewrite: { '^/api': '' },
}));

// Serve form page
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'templates', 'index.html'));
});

// Serve success page
app.get('/submit-success', (req, res) => {
    res.sendFile(path.join(__dirname, 'templates', 'success.html'));
});

app.listen(port, () => {
  console.log(`Frontend listening on port ${port}`);
});
