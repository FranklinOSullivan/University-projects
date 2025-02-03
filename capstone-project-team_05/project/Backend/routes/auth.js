var express = require('express');
var router = express.Router();
const admin = require('firebase-admin');

//this is a middleware function that will run before any other function in this file
router.use('/', (req, res, next)=>{
    console.log('auth route is called'); // This will log to the console
    next(); // This will pass the request to the next middleware function in the stack
});

module.exports = router;
