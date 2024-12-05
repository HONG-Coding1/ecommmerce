import 'package:ecommerce/Widget/Contents/Cart/controller.dart';
import 'package:ecommerce/Widget/Contents/Cart/model.dart';
import 'package:ecommerce/Widget/Contents/Cart/payment_detail.dart';
import 'package:ecommerce/Widget/homescreen.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Navigate to HomePage when back button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainApp(),
          ),
        );
        return false; // Return false to prevent the default back behavior
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Cart"),
        ),
        body: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return const Center(
              child: Text("Your cart is empty."),
            );
          }
          return Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                CartItem item = cartController.cartItems[index];
                return Card(
                  elevation: 10.0,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.network(
                        item.imageUrl,
                        width: 120,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$${item.price}"),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartController.updateQuantity(
                                      item.id, item.quantity - 1);
                                },
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cartController.updateQuantity(
                                      item.id, item.quantity + 1);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Checkbox to select item
                          Checkbox(
                            value: item.isSelected, // Ensure this is a bool
                            onChanged: (bool? value) {
                              if (value != null) {
                                cartController.toggleItemSelection(
                                    item.id); // Toggle selection
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded),
                            onPressed: () {
                              cartController.removeFromCart(item.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
        bottomNavigationBar: Obx(
          () {
            double selectedTotal = cartController.totalSelectedPrice;
            bool isAnyItemSelected =
                cartController.cartItems.any((item) => item.isSelected);

            return Container(
              color: const Color(0xFFFFFFFF),
              height: 130,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total: "),
                        Text("\$${selectedTotal.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CupertinoButton(
                      color: isAnyItemSelected ? Colors.red : Colors.grey,
                      onPressed: isAnyItemSelected
                          ? () {
                              Get.to(() => PaymentDetail());
                            }
                          : null, // Disable if no items selected
                      child: const Text(
                          "Continue Payment Method"), // Disable the button if no items selected
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
