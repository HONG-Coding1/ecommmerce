// ignore_for_file: avoid_print

import 'package:ecommerce/Widget/Contents/Cart/cart_page.dart';
import 'package:ecommerce/Widget/Contents/Cart/controller.dart';
import 'package:ecommerce/Widget/Contents/Cart/model.dart';
import 'package:ecommerce/Widget/Contents/Cart/payment_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  final dynamic product; // Product data passed to this page
  ProductDetailPage({required this.product, super.key});

  final CartController cartController =
      Get.find(); // GetX CartController instance

  @override
  Widget build(BuildContext context) {
    // Extract product properties
    final String productId =
        product['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    final String productName = product['name'] ?? 'Unknown Product';
    final double productPrice =
        double.tryParse(product['price'].toString()) ?? 0.0;
    final String productImage = product['image'] ?? '';
    final String productDescription =
        product['description'] ?? 'No description available.';

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Detail Product")),
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                // Cart icon
                const ImageIcon(
                  AssetImage('assets/Buy.png'),
                  color: Colors.black,
                  size: 30.0,
                ),
                // Badge showing total quantity
                Obx(
                  () {
                    int totalItems = cartController.cartItems
                        .fold(0, (sum, item) => sum + item.quantity);

                    if (totalItems > 0) {
                      return Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            '$totalItems',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // No badge if cart is empty
                    }
                  },
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
              print("Cart button pressed!");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              productImage,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    productName,
                    style: const TextStyle(fontSize: 20, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("Wishlist button pressed!");
                  },
                  icon: const ImageIcon(
                    AssetImage("assets/Heart.png"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '\$${productPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              productDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add product to cart
                        print("Adding product with ID: $productId to cart");
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
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Buy Now button pressed!");
                        Get.to(() => PaymentDetail());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Buy Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


