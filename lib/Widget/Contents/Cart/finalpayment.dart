// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:ecommerce/Widget/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/Widget/Contents/Cart/controller.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final CartController cartController = Get.find<CartController>();

  bool showCheckmark = true;
  bool showPaymentDetails = false;

  @override
  void initState() {
    super.initState();

    // After 2 seconds, hide the checkmark and show payment details
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showCheckmark = false;
        showPaymentDetails = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: showCheckmark
            ? _buildCheckmarkScreen()
            : showPaymentDetails
                ? _buildPaymentDetailsScreen()
                : Container(),
      ),
    );
  }

  // First screen: Show checkmark inside a circle
  Widget _buildCheckmarkScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 50,
          ),
        ),
        const SizedBox(height: 20),
        const CircularProgressIndicator(),
      ],
    );
  }

  // Second screen: Show payment details with buttons
  Widget _buildPaymentDetailsScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Details Header
          const Text(
            "Payment Detail",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Payment Information
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPaymentDetailRow("Order No.", "1485156215495612"),
                _buildPaymentDetailRow("Total",
                    "\$${cartController.totalSelectedPrice.toStringAsFixed(2)}"), // Use totalSelectedPrice
                _buildPaymentDetailRow("Date & Time", "05.11.2023 - 21:29:10"),
                _buildPaymentDetailRow("Payment Method", "PAYTM"),
                _buildPaymentDetailRow("Name", "ASHUTOSH SHARMA"),
                _buildPaymentDetailRow("Email", "ashutoshuiux@gmail.com"),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "A receipt will be sent directly to the email",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 40),
          // Buttons
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle review action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 20),
                  ),
                  child: const Text('Review'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clear the cart after payment
                    cartController.cartItems
                        .removeWhere((item) => item.isSelected);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainApp(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.purple),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 20),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Utility method to build a row of payment details
  Widget _buildPaymentDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
