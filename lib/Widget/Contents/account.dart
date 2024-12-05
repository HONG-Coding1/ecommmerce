import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Authentication/controller/controller.dart'; // Make sure to import AuthController if needed

class AccountPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  AccountPage({super.key}); // Find the instance of AuthController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Account Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authController.signOut(); // You can also call it here for testing
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
