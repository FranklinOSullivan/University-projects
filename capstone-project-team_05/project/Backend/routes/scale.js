var express = require('express');
var router = express.Router();

//this is a middleware function that will run before any other function in this file
router.use('/', (req, res, next)=>{
    console.log('scale route is called'); // This will log to the console
    next(); // This will pass the request to the next middleware function in the stack
});

// POST: /scale/upload/weight
router.post('/upload/weight', (req, res) => {
    //TODO: check which scale id and store it in database

    const { weight } = req.body;
    console.log('Weight:', weight);
    res.status(200).json({ message: 'Weight received' });
});

module.exports = router;
