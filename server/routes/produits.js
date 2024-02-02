//imports
const express = require("express"); 
const produitsControllers = require("../controllers/produits");
const router = express.Router();

//les differentes routes
router.post("/",produitsControllers.insertProducts);
router.get('/',produitsControllers.getAllProduits);
router.get('/:id',produitsControllers.getOneProduit);
router.put('/update/:id',produitsControllers.updateProduit);
router.put('/newStock/:id',produitsControllers.updatField);
router.delete('/:id',produitsControllers.deleteproduit);

module.exports = router;