const express = require("express");
const auth = require("../middleware/auth");
const User = require("../models/user");
const { Product } = require("../models/product");
const userRouter = express.Router();

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    const user = await User.findById(req.user);
    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
      await user.save();
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          // Check if the product is already in the cart
          isProductFound = true;
        }
      }
      if (isProductFound) {
        let product = user.cart.find((item) => item.product._id.equals(id));
        product.quantity += 1; // Increment quantity if product is already in cart
      } else {
        user.cart.push({ product, quantity: 1 }); // Add new product to cart
      }
    }
    await user.save();
    res.status(200).json(user);
  } catch (error) {
    console.error("Error adding to cart:", error);
    res.status(500).json({ error: error.message });
  }
});

userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    const user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        // Check if the product is already in the cart
        user.cart[i].quantity -= 1; // Decrement quantity if product is already in cart
        if (user.cart[i].quantity <= 0) {
          user.cart.splice(i, 1); // Remove product from cart if quantity is 0
        }
        break; // Exit loop after finding the product
      }
    }
    await user.save();
    res.status(200).json(user);
  } catch (error) {
    console.error("Error adding to cart:", error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
