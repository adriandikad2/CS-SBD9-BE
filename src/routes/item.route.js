const express = require('express');
const itemController = require('../controllers/item.controller');

const router = express.Router();

router.post('/create', itemController.createItem);
router.get('/', itemController.getAllItems);
router.get('/byId/:id', itemController.getItemById);
router.get('/byStoreId/:store_id', itemController.getItemsByStoreId);
router.put('/', itemController.updateItem);
router.delete('/:id', itemController.deleteItem);

module.exports = router;