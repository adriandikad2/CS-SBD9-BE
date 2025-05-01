const { query } = require('../database/pg.database');

const checkStoreExists = async (store_id) => {
    try {
        const storeCheck = await query('SELECT * FROM stores WHERE id = $1', [store_id]);
        return storeCheck.rowCount > 0;
    } catch (error) {
        console.error('Store doesnt exist', error);
        return false;
    }
};

const createItem = async ({ name, price, store_id, image_url, stock }) => {
    const text = `
        INSERT INTO items (name, price, store_id, image_url, stock, created_at)
        VALUES ($1, $2, $3, $4, $5, NOW())
        RETURNING *;
    `;
    const values = [name, price, store_id, image_url, stock];
    const result = await query(text, values);
    return result.rows[0];
};

const getAllItems = async () => {
    const text = 'SELECT * FROM items';
    const result = await query(text);
    return result.rows;
};

const getItemById = async (id) => {
    try {
        const text = 'SELECT * FROM items WHERE id = $1';
        const result = await query(text, [id]);
        if (result.rowCount === 0) {
            return null;
        }
        return result.rows[0];
    } catch (error) {
        console.error('Error fetching item by ID', error);
        return null;
    }
};

const getItemsByStoreId = async (store_id) => {
    try {
        const text = 'SELECT * FROM items WHERE store_id = $1';
        const result = await query(text, [store_id]);
        return result.rows;
    } catch (error) {
        console.error('Error fetching items by store ID', error);
        return [];
    }
};

const updateItem = async ({ id, name, price, store_id, image_url, stock }) => {
    try {
        const text = `
            UPDATE items
            SET name = $1, price = $2, store_id = $3, image_url = $4, stock = $5
            WHERE id = $6
            RETURNING *;
        `;
        const values = [name, price, store_id, image_url, stock, id];
        const result = await query(text, values);
        if (result.rowCount === 0) {
            return null;
        }
        return result.rows[0];
    } catch (error) {
        console.error('Error updating item', error);
        return null;
    }
};

const updateItemStock = async (id, quantity) => {
    try {
        const text = "UPDATE items SET stock = stock + $2 WHERE id = $1 RETURNING *";
        const result = await query(text, [id, quantity]);
        return result.rows[0];
    } catch (error) {
        console.error("Error updating item stock", error);
        return null;
    }
};

const deleteItem = async (id) => {
    try {
        const text = 'DELETE FROM items WHERE id = $1';
        const result = await query(text, [id]);
        return result.rowCount > 0;
    } catch (error) {
        console.error('Error deleting item', error);
        return false;
    }
};

module.exports = {
    createItem,
    checkStoreExists,
    getAllItems,
    getItemById,
    getItemsByStoreId,
    updateItem,
    updateItemStock,
    deleteItem,
};
