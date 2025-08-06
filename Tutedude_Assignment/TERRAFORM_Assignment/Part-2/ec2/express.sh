#!/bin/bash
# Update and install necessary packages
apt update -y
apt install -y nodejs npm

mkdir -p /home/ubuntu/frontend
cd /home/ubuntu/frontend

cat <<EOF > app.js
const express = require('express');
const app = express();
app.get('/', (req, res) => {
    res.send('Hello from Express!');
});
app.listen(3000, () => {
    console.log('Express app listening on port 3000');
});
EOF

npm init -y
npm install express

nohup node app.js > /home/ubuntu/frontend.log 2>&1 &
