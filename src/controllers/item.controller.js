const itemRepository = require('../repositories/item.repository');

const createItem = async (req, res) => {
    try {
        const { name, price, store_id, image, stock } = req.query;

        if (!image) {
            return res.status(400).json({ success: false, message: 'Image URL is required', payload: null });
        }

        const storeExists = await itemRepository.checkStoreExists(store_id);
        if (!storeExists) {
            return res.status(400).json({ success: false, message: 'Store ID does not exist', payload: null });
        }

        const newItem = await itemRepository.createItem({
            name,
            price,
            store_id,
            image_url: image,
            stock,
        });

        res.status(201).json({
            success: true,
            message: 'Item created',
            payload: newItem,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
            payload: null,
        });
    }
};

const getAllItems = async (req, res) => {
    try {
        const items = await itemRepository.getAllItems();
        res.status(200).json({
            success: true,
            message: 'Items found',
            payload: items,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
            payload: null,
        });
    }
};

const getItemById = async (req, res) => {
    try {
        const { id } = req.params;
        const item = await itemRepository.getItemById(id);
        if (!item) {
            return res.status(404).json({
                success: false,
                message: 'Item not found',
                payload: null,
            });
        }
        res.status(200).json({
            success: true,
            message: 'Item found',
            payload: item,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
            payload: null,
        });
    }
};

const getItemsByStoreId = async (req, res) => {
    try {
        const store_id = req.params.store_id || req.query.store_id;
        if (!store_id) {
            return res.status(400).json({
                success: false,
                message: 'Store ID is required',
                payload: null,
            });
        }

        const storeExists = await itemRepository.checkStoreExists(store_id);
        if (!storeExists) {
            return res.status(404).json({
                success: false,
                message: 'Store does not exist',
                payload: null,
            });
        }
        const items = await itemRepository.getItemsByStoreId(store_id);
        res.status(200).json({
            success: true,
            message: 'Items found',
            payload: items,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
            payload: null,
        });
    }
};

const updateItem = async (req, res) => {
    try {
        const { id, name, price, store_id, image, stock } = req.query;

        if (!id || !name || !price || !store_id || !image || !stock) {
            return res.status(400).json({ success: false, message: 'All fields are required', payload: null });
        }

        const storeExists = await itemRepository.checkStoreExists(store_id);
        if (!storeExists) {
            return res.status(404).json({ success: false, message: 'Store does not exist', payload: null });
        }

        const updatedItem = await itemRepository.updateItem({
            id,
            name,
            price,
            store_id,
            image_url: image,
            stock,
        });

        if (!updatedItem) {
            return res.status(404).json({ success: false, message: 'Item not found', payload: null });
        }

        res.status(200).json({
            success: true,
            message: 'Item updated',
            payload: updatedItem,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
            payload: null,
        });
    }
};

const deleteItem = async (req, res) => {
    try {
        const { id } = req.params;

        const item = await itemRepository.getItemById(id);
        if (!item) {
            return res.status(404).json({
                success: false,
                message: 'Item not found',
                payload: null,
            });
        }

        await itemRepository.deleteItem(id);
        res.status(200).json({
            success: true,
            message: 'Item deleted',
            payload: item,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
            payload: null,
        });
    }
};

module.exports = {
    createItem,
    getAllItems,
    getItemById,
    getItemsByStoreId,
    updateItem,
    deleteItem,
};
