const db = require("../database/pg.database");

exports.createUser = async (user) => {
    try {
        const res = await db.query(
            "INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *",
            [user.email, user.password, user.name]
        );
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
}

exports.loginUser = async (email) => {
    try {
        const res = await db.query("SELECT * FROM users WHERE email = $1", [email]);
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
}

exports.getUserByEmail = async (email) => {
    try {
        const res = await db.query("SELECT * FROM users WHERE email = $1", [email]);
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
}

exports.getUserById = async (id) => {
    try {
        const res = await db.query("SELECT * FROM users WHERE id = $1", [id]);
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
}

exports.updateUser = async (user) => {
    try {
        const res = await db.query(
            "UPDATE users SET email = $2, password = $3, name = $4 WHERE id = $1 RETURNING *",
            [user.id, user.email, user.password, user.name]
        );
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
}

exports.deleteUser = async (id) => {
    try {
        const res = await db.query("DELETE FROM users WHERE id = $1", [id]);
        return res.rowCount;
    } catch (error) {
        console.error("Error executing query", error);
    }
}

exports.topUpBalance = async (id, amount) => {
    try {
        const res = await db.query(
            "UPDATE users SET balance = balance + $2 WHERE id = $1 RETURNING *",
            [id, amount]
        );
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
}

exports.updateUserBalance = async (id, amount) => {
    try {
        const res = await db.query(
            "UPDATE users SET balance = balance + $2 WHERE id = $1 RETURNING *",
            [id, amount]
        );
        return res.rows[0];
    } catch (error) {
        console.error("Error executing query", error);
    }
}