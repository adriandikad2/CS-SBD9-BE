const TransactionController = require('../controllers/transaction.controller');
const express = require('express');
const router = express.Router();

router.post('/create', TransactionController.createTransaction);
router.post('/pay/:id', TransactionController.payTransaction);
router.delete('/:id', TransactionController.deleteTransaction);
router.get('/', TransactionController.getAllTransactions);

module.exports = router;