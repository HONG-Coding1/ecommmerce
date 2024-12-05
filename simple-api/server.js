const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');

// Path to your service account file
const serviceAccount = require('./firebase-service-account.json');

// Initialize Firebase Admin SDK with the service account
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const app = express();
const db = admin.firestore();

// Enable CORS
app.use(cors());

// Enable JSON parsing for POST requests
app.use(express.json());

// API to get all products from Firestore
app.get('/products', async (req, res) => {
  try {
    const productsSnapshot = await db.collection('products').get();
    const products = productsSnapshot.docs.map(doc => doc.data());
    res.json(products);
  } catch (error) {
    res.status(500).send('Error retrieving products');
  }
});

// API to add a new product to Firestore
app.post('/products', async (req, res) => {
  try {
    const { name, description, price, category, image } = req.body;

    // Simple validation to ensure all fields are provided
    if (!name || !description || !price || !category || !image) {
      return res.status(400).send('All fields are required.');
    }

    // Add the new product to the Firestore database
    const productRef = await db.collection('products').add({
      name,
      description,
      price,
      category,
      image,
    });

    res.status(201).send({ id: productRef.id, name, description, price, category, image });
  } catch (error) {
    console.error('Error adding product:', error.message);
    res.status(500).send('Error adding product: ' + error.message);
  }
});

// Start the server
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
