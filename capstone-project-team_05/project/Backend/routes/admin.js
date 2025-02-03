var express = require('express');
var router = express.Router();
const admin = require('firebase-admin');

//this is a middleware function that will run before any other function in this file
router.use('/', (req, res, next)=>{
    console.log('admin route is called'); // This will log to the console
    next(); // This will pass the request to the next middleware function in the stack
});

router.use('/', (req, res, next)=>{
    console.log('check if user is admin');
    next(); // This will pass the request to the next middleware function in the stack
});

// POST /admin/accounts
// Create a new user account
router.post('/accounts', async function(req, res){
    console.log('add user');
try {
    const { email, password } = req.body;
    const userRecord = await admin.auth().createUser({
        email,
        password
    });

    res.status(201).json(
        {
            message: 'User created successfully',
            id: userRecord.uid
        }
    );
} catch (error) {
    console.error('Error signing up user:', error);
    res.status(500).json({ error });
}
});

module.exports = router;
