const express = require('express');
const path = require('path');
const fs = require('fs');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const port = 3000;

// Frontend sees /api as local, which ingress maps to the backend
const BACKEND_URL = 'http://localhost/api';

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
