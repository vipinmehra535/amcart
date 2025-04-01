const mongoose = require("mongoose");
const ratingSchema = require("./rating");

const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },

  description: {
    type: String,
    required: true,
    trim: true,
  },

  images: [
    {
      type: String,
      required: true,
      trim: true,
    },
  ],
  quantity: {
    type: Number,
    required: true,
  },

  price: {
    type: Number,
    required: true,
  },

  category: {
    type: String,
    required: true,
  },

  rating: [ratingSchema],
});

const Product = mongoose.model("product", productSchema);

module.exports = Product;
