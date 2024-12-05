// ignore_for_file: avoid_print

import 'package:ecommerce/Widget/Contents/Cart/controller.dart';
import 'package:ecommerce/Widget/Contents/Cart/model.dart';
import 'package:ecommerce/Widget/Contents/Home/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  final List<dynamic> products;
  final CartController cartController = Get.find(); // Get the controller

  ProductList({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              // Safely handle null values with fallback
              final String productName = product['name'] ?? 'No name available';
              final String productImage = product['image'] ?? '';
              final double productPrice = (product['price'] ?? 0).toDouble();

              final String productId = product['id'] ??
                  DateTime.now().millisecondsSinceEpoch.toString();

              return Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(12.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16.0)),
                          child: Image.network(
                            productImage,
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Icon(Icons.error)); // Handle errors
                            },
                          ),
                        ),
                        // Product Name and Price
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '\$${productPrice.toString()}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromARGB(255, 50, 51, 50)),
                              ),
                            ],
                          ),
                        ),
                        // Add to Cart Button
                        Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: ElevatedButton(
                              onPressed: () {
                                print(
                                    "Adding product with ID: $productId to cart");
                                CartItem cartItem = CartItem(
                                  id: productId,
                                  name: productName,
                                  price: productPrice,
                                  imageUrl: productImage,
                                  quantity: 1,
                                );
                                cartController.addToCart(cartItem);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                'Add to cart',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
