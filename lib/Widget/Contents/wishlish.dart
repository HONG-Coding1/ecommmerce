import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disables the back button in AppBar
        title: const Text('Wishlist'),
      ),
      body: const Center(
        child: Text('Display wishlist items here'),
      ),
    );
  }
}
