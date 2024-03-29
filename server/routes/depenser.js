const express = require('express')
const router = express.Router()
const depensesControllers = require('../controllers/depenser');

router.post('/',depensesControllers.addDepenses)
router.get('/',depensesControllers.getDepenses)
router.delete('/:id',depensesControllers.deleteDepenses)

module.exports = router