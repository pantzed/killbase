'use strict'

const env = 'development';
const config = require('/knexfile.js')[env];
const knex = require('knex')(config);
const express = require('express');
const port = process.env.PORT || 8000;

const app = express();

