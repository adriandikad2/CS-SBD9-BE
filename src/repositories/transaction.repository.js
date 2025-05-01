const db = require("../database/pg.database");

exports.createTransaction = async (transaction) => {
    try {
        const res = await db.query(
            "INSERT INTO transactions (item_id, quantity, user_id, total, status, created_at) VALUES ($1, $2, $3, (SELECT price FROM items WHERE id = $1) * $2, 'pending', NOW()) RETURNING *",
            [transaction.item_id, transaction.quantity, transaction.user_id]
        );
        return res.rows[0];
    }  catch (error) {
        console.error("Error executing query", error);
    }
};

exports.getTransactionById = async (id) => {
    try {
        const res = await db.query("SELECT * FROM transactions WHERE id = $1", [id]);
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
};

exports.updateTransactionStatus = async (id, status) => {
    try {
        const res = await db.query(
            "UPDATE transactions SET status = $2 WHERE id = $1 RETURNING *",
            [id, status]
        );
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
};

exports.deleteTransaction = async (id) => {
    try {
        const res = await db.query("DELETE FROM transactions WHERE id = $1 RETURNING *", [id]);
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
};

exports.getAllTransactions = async () => {
    try {
        const res = await db.query(`
            SELECT 
                t.*, 
                jsonb_build_object(
                    'id', u.id, 
                    'name', u.name, 
                    'email', u.email, 
                    'password', u.password, 
                    'balance', u.balance, 
                    'created_at', u.created_at
                ) AS user,
                jsonb_build_object(
                    'id', i.id, 
                    'name', i.name, 
                    'price', i.price, 
                    'store_id', i.store_id, 
                    'image_url', i.image_url, 
                    'stock', i.stock, 
                    'created_at', i.created_at
                ) AS item
            FROM transactions t
            JOIN users u ON t.user_id = u.id
            JOIN items i ON t.item_id = i.id
        `);
        return res.rows;
    } catch (error) {
        console.error("Error executing query", error);
    }
};