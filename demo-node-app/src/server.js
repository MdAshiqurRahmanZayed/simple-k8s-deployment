const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const port = process.env.PORT || 5050;

const distDir = path.join(__dirname, '..', 'dist');
const distIndex = path.join(distDir, 'index.html');
const fallbackIndex = path.join(__dirname, 'public', 'index.html');

// Serve the built React app from dist/ if available, otherwise serve public/
if (fs.existsSync(distDir)) {
  app.use(express.static(distDir));
} else {
  app.use(express.static(path.join(__dirname, 'public')));
}

app.get('/api', (req, res) => {
  res.json({ message: 'Hello World changes'});
});

// Catch-all: serve React's index.html (SPA support) or fallback for local dev
app.get('*', (req, res) => {
  const indexFile = fs.existsSync(distIndex) ? distIndex : fallbackIndex;
  res.sendFile(indexFile);
});

let server;

if (require.main === module) {
  const PORT = process.env.PORT || 5050;
  server = app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}

module.exports = app