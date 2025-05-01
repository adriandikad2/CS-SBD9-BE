const transactionRepository = require('../repositories/transaction.repository');
const itemRepository = require('../repositories/item.repository');
const userRepository = require('../repositories/user.repository');
const baseResponse = require('../utils/baseResponse.util');

exports.createTransaction = async (req, res) => {
    const { item_id, quantity, user_id } = req.body;
    if (!item_id || !quantity || !user_id || quantity <= 0) {
        return baseResponse(res, false, 400, "Item ID, quantity, and user ID are required, and quantity must be larger than 0", null);
    }
    try {
        const transaction = await transactionRepository.createTransaction(req.body);
        baseResponse(res, true, 201, "Transaction created successfully", transaction);
    } catch (error) {
        baseResponse(res, false, 500, error.message || "Server Error", error);
    }
};

exports.payTransaction = async (req, res) => {
    const { id } = req.params;
    try {
        const transaction = await transactionRepository.getTransactionById(id);
        if (!transaction) {
            return baseResponse(res, false, 404, "Transaction not found", null);
        }

        const item = await itemRepository.getItemById(transaction.item_id);
        if (!item || item.stock < transaction.quantity) {
            return baseResponse(res, false, 400, "Insufficient item stock", null);
        }

        const user = await userRepository.getUserById(transaction.user_id);
        if (!user || user.balance < transaction.total) {
            return baseResponse(res, false, 400, "Insufficient user balance", null);
        }

        await itemRepository.updateItemStock(transaction.item_id, -transaction.quantity);
        await userRepository.updateUserBalance(transaction.user_id, -transaction.total);
        const updatedTransaction = await transactionRepository.updateTransactionStatus(id, 'paid');

        baseResponse(res, true, 200, "Payment successful", updatedTransaction);
    } catch (error) {
        baseResponse(res, false, 500, "Failed to pay", error);
    }
};

exports.deleteTransaction = async (req, res) => {
    const { id } = req.params;
    if (!id) {
        return baseResponse(res, false, 400, "Transaction ID is required", null);
    }
    try {
        const deletedTransaction = await transactionRepository.deleteTransaction(id);
        if (!deletedTransaction) {
            return baseResponse(res, false, 404, "Transaction not found", null);
        }
        baseResponse(res, true, 200, "Transaction deleted successfully", deletedTransaction);
    } catch (error) {
        baseResponse(res, false, 500, "Error deleting transaction", error);
    }
};

exports.getAllTransactions = async (req, res) => {
    try {
        const transactions = await transactionRepository.getAllTransactions();
        baseResponse(res, true, 200, "Transactions found", transactions);
    } catch (error) {
        baseResponse(res, false, 500, "Error retrieving transactions", error);
    }
};

