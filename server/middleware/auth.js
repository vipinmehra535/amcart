const jwt = require("jsonwebtoken");

// This middleware function is used to verify the authenticity of the user
// making a request. It checks if the request contains a valid authentication
// token, and if so, it verifies the token and adds the user's id to the
// request object.
const auth = async (req, res, next) => {
  try {
    // Get the token from the request header
    const token = req.header("x-auth-token");

    // If no token is present, return an error
    if (!token) {
      return res.status(401).json({
        msg: "No auth token, access denied",
      });
    }

    // Verify the token using the secret key
    const verified = jwt.verify(token, "passwordKey");

    // If the verification fails, return an error
    if (!verified) {
      return res.status(401).json({
        msg: "Token verification failed, authorization denied.",
      });
    }

    // If the verification is successful, add the user's id to the request object
    // and call the next middleware function
    req.user = verified.id;
    req.token = token;
    next();
  } catch (err) {
    // If any error occurs during the verification process, return a 500 error
    res.status(500).json({ error: err.message });
  }
};

module.exports = auth;
