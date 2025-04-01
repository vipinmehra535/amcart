const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth");
const Product = require("../models/product");

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      // Search for products with names that contain the search term
      // The $regex operator allows us to use a regular expression to search
      // for the name. The "i" flag makes the search case-insensitive.
      name: { $regex: new RegExp(req.params.name, "i") },
    });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.post("/api/rate-product", auth, async (req, res) => {
  const { id, rating } = req.body;
  try {
    // Find the product by its ID and update its rating
    const product = await Product.findById(id);
    // If the product is not found, return an error
    if (!product) {
      return res.status(404).json({ error: "Product not found" });
    }
    for (let i = 0; i < product.rating.length; i++) {
      if (product.rating[i].userId === req.user._id) {
        product.rating[i].rating = rating;
        await product.save();
        return res.json(product);
      }
    }
    product.rating.push({ userId: req.user._id, rating });
    await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
