const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth");
const Product = require("../models/product");

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category);
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    console.log(req.params.name);
    // Use regex to search for products with names that contain the query string
    // The $options: "i" flag makes the search case-insensitive
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = productRouter;
