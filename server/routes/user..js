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
        if (user.cart[i].product._id.equal(product._id)) {
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
    res.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
