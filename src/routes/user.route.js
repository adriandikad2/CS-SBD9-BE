const UserController = require('../controllers/user.controller');
const express = require('express');
const router = express.Router();

router.post('/register', UserController.createUser);
router.post('/login', UserController.loginUser);
router.post('/topUp', UserController.topUpBalance);
router.get('/:email', UserController.getUserByEmail);
router.put('/', UserController.updateUser);
router.delete('/:id', UserController.deleteUser);

module.exports = router;