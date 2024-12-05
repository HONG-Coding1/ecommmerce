// ignore_for_file: avoid_print

import 'package:ecommerce/Widget/Contents/Cart/cart_page.dart';
import 'package:ecommerce/Widget/Contents/Cart/controller.dart';
import 'package:ecommerce/Widget/Contents/Home/homepage.dart';
import 'package:ecommerce/Widget/Contents/wishlish.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Widget/Contents/account.dart';
import 'package:ecommerce/Widget/Contents/history.dart';
import 'package:get/get.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final CartController cartController =
      Get.find<CartController>(); // Access the CartController
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const WishlistPage(),
    const HistoryPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disables the back button in AppBar
        title: const Text('De Shoes'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
              // Use pushReplacement to avoid stacking screens
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
              print("Cart button pressed!");
            },
          ),
          IconButton(
            icon: const ImageIcon(
              AssetImage('assets/Notification.png'),
              color: Colors.black,
            ),
            onPressed: () {
              print("Notification button pressed!");
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/Home.png"),
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/Heart.png"),
              color: Colors.black,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/Paper.png"),
              color: Colors.black,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/Profile.png"),
              color: Colors.black,
            ),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.black, // Label color when selected
        unselectedItemColor:
            Colors.black.withOpacity(0.1), // Label color unselected
        backgroundColor: Colors.white, // Background color
        iconSize: 30, // Adjust icon size
        selectedFontSize: 16, // Adjust font size
        unselectedFontSize: 14, // Font size for unselected items
        type: BottomNavigationBarType.shifting, // To prevent shifting behavior
      ),
    );
  }
}
