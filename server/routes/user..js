const express = require("express");
const auth = require("../middleware/auth");
const User = require("../models/user");
const { Product } = require("../models/product");
const Order = require("../models/order");
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
    console.error("Error removing to cart:", error);
    res.status(500).json({ error: error.message });
  }
});

// save user address
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// order product
userRouter.post("/api/order", auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];

    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res
          .status(400)
          .json({ msg: `${product.name} is out of stock!` });
      }
    }

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.get("/api/orders/me", auth, async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.user });
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
