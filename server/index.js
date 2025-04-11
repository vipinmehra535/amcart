const express = require("express");
const mongoose = require("mongoose");

const router = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user.");

const PORT = 5000;
const app = express();
app.use(express.json());

app.use("/", router);
app.use("/", adminRouter);
app.use("/", productRouter);
app.use("/", userRouter);

const DB =
  "mongodb+srv://vipin:9999855768@mongodb.rcpk4rc.mongodb.net/?retryWrites=true&w=majority&appName=Mongodb";

app.get("/", (req, res) => {
  res.send("Hello World!");
});

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
