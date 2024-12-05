/**
 * Firebase Functions - REST API Example
 */
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(); // Initialize Firebase Admin SDK

// API to get all products from Firestore
exports.getProducts = functions.https.onRequest(async (req, res) => {
  try {
    const snapshot = await admin.firestore().collection("products").get();
    const products = snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    res.status(200).json(products);
  } catch (error) {
    console.error("Error retrieving products:", error.message);
    res.status(500).send(`Error retrieving products: ${error.message}`);
  }
});

// API to add a new product to Firestore
exports.addProduct = functions.https.onRequest(async (req, res) => {
  try {
    const { name, description, price, category, image } = req.body;

    // Validate input
    if (!name || !description || !price || !category || !image) {
      return res.status(400).send("All fields are required.");
    }

    const newProduct = { name, description, price, category, image };
    const productRef = await admin.firestore().collection("products").add(newProduct);

    res.status(201).json({ id: productRef.id, ...newProduct });
  } catch (error) {
    console.error("Error adding product:", error.message);
    res.status(500).send(`Error adding product: ${error.message}`);
  }
});

// API to update a product in Firestore
exports.updateProduct = functions.https.onRequest(async (req, res) => {
  try {
    const { id, name, description, price, category, image } = req.body;

    if (!id || !name || !description || !price || !category || !image) {
      return res.status(400).send("All fields are required, including ID.");
    }

    const productRef = admin.firestore().collection("products").doc(id);
    await productRef.update({ name, description, price, category, image });

    res.status(200).send(`Product with ID ${id} updated successfully.`);
  } catch (error) {
    console.error("Error updating product:", error.message);
    res.status(500).send(`Error updating product: ${error.message}`);
  }
});

// API to delete a product from Firestore
exports.deleteProduct = functions.https.onRequest(async (req, res) => {
  try {
    const { id } = req.body;

    if (!id) {
      return res.status(400).send("Product ID is required.");
    }

    const productRef = admin.firestore().collection("products").doc(id);
    await productRef.delete();

    res.status(200).send(`Product with ID ${id} deleted successfully.`);
  } catch (error) {
    console.error("Error deleting product:", error.message);
    res.status(500).send(`Error deleting product: ${error.message}`);
  }
});
