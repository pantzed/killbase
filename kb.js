'use strict'

const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');
const express = require('express');

const env = 'development';
const knexConfigPath = path.join(__dirname, 'knexfile.js');
const config = require(knexConfigPath)[env];
const knex = require('knex')(config);
const port = process.env.PORT || 8000;

const app = express();

app.disable('x-powered-by');
app.use(bodyParser.json());


app.get('/assassins', (req, res) => {
  console.log(req.body);
  let opp = req.body.opp;
  console.log(opp);

  if (req.body.id !== undefined) {
      res.send(x);
  }
  else {
    knex('assassins').then((x) => {
      res.send(x);
    });
  }
});

app.get('/contracts', (req, res) => {
  knex('contracts').then((x) => {
    res.send(x)
  });
});

app.use(function(req, res) {
  res.sendStatus(404);
});

app.listen(port, function() {
  console.log('Listening on port', port);
});

module.exports = app;