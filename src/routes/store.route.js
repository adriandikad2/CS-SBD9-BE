const StoreController = require('../controllers/store.controller');
const express = require('express');
const router = express.Router();

router.get('/getAll', StoreController.getAllStores);
router.post('/create', StoreController.createStore);
router.get('/:id', StoreController.getStoreById);
router.put('', StoreController.updateStore);
router.delete('/:id', StoreController.deleteStore);

module.exports = router;