// ignore_for_file: avoid_print

import 'package:ecommerce/Widget/Contents/Cart/controller.dart';
import 'package:ecommerce/Widget/Contents/Cart/finalpayment.dart';
import 'package:ecommerce/Widget/Contents/Cart/model.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentDetail extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  PaymentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text("Summary"),
      ),
      body: Obx(
        () {
          if (cartController.cartItems.isEmpty) {
            return const Center(
              child: Text("Your cart is empty."),
            );
          }

          double subtotal =
              cartController.totalSelectedPrice; // Calculate subtotal
          double serviceFee = 2.31; // You can adjust this as needed
          double total =
              subtotal + serviceFee; // Total = Subtotal + Service Fee

          return Container(
            padding: const EdgeInsets.all(20),
            color: const Color.fromARGB(255, 255, 255, 255), // Background color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // List of selected items
                const Text("Summary",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      CartItem item = cartController.cartItems[index];
                      return ListTile(
                        title: Text(item.name),
                        trailing: Text("\$${item.price}"),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Subtotal and total
                Text("Subtotal: \$${subtotal.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("Service fee: \$${serviceFee.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Text("Total: \$${total.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                // Pay Now button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CupertinoButton(
                    color: Colors.teal,
                    child: const Text("Pay Now",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      // Handle payment process here
                      Get.to(() => PaymentScreen());
                      print("Pay Now Clicked ");
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
