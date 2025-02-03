var createError = require('http-errors');
require('dotenv').config();
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

// Firebase Admin SDK
const admin = require('firebase-admin');

var serviceAccount = require("./serviceAccount.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var adminRouter = require('./routes/admin');
var authRouter = require('./routes/auth');
var scaleRouter = require('./routes/scale');

var app = express();

// Middleware to check if the API key is valid
const checkAPIKey = (req, res, next) => {
  const apiKey = req.headers['x-api-key']; // API key is provided in the 'x-api-key' header
  console.log(apiKey);
  console.log(process.env.API_KEY)
  if (!apiKey || apiKey !== process.env.API_KEY) {
      return res.status(401).json({ error: 'Unauthorized' });
  }

  // If the API key is valid, continue to the next middleware or route handler
  next();
};

// Apply the api check middleware to all requests before continuing
app.use(checkAPIKey);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/admin', adminRouter);
app.use('/auth', authRouter);
app.use('/scale', scaleRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
