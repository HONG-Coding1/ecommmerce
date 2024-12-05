// ignore_for_file: avoid_print

import 'package:ecommerce/Widget/Contents/Cart/model.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  // Add a product to the cart
  void addToCart(CartItem newItem) {
    int index = cartItems.indexWhere((item) => item.id == newItem.id);

    if (index == -1) {
      cartItems.add(newItem);
      print("Product added to cart: ${newItem.name} with ID: ${newItem.id}");
    } else {
      CartItem existingItem = cartItems[index];
      existingItem.quantity += 1;
      cartItems[index] = existingItem;
      print(
          "Updated product quantity for: ${existingItem.name} to ${existingItem.quantity}");
    }
  }

  // Update quantity
  void updateQuantity(String id, int newQuantity) {
    int index = cartItems.indexWhere((item) => item.id == id);

    if (index != -1) {
      if (newQuantity <= 0) {
        removeFromCart(id);
      } else {
        CartItem updatedItem = cartItems[index];
        updatedItem.quantity = newQuantity;
        cartItems[index] = updatedItem;
      }
    }
  }

  // Remove product from the cart
  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.id == id);
  }

  // Get the total price of all items in the cart
  double get totalPrice {
    return cartItems.fold(
        0, (total, item) => total + item.price * item.quantity);
  }

  // Get the total price of selected items
  double get totalSelectedPrice {
    return cartItems
        .where((item) => item.isSelected)
        .fold(0, (total, item) => total + item.price * item.quantity);
  }

  // Toggle selection of a single item
  void toggleItemSelection(String id) {
    int index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      CartItem updatedItem = cartItems[index];
      updatedItem.isSelected =
          !updatedItem.isSelected; // Toggle the isSelected state
      cartItems[index] = updatedItem; // Update the list
    }
  }

  // Select or deselect all items at once
  void toggleSelectAll(bool selectAll) {
    for (var item in cartItems) {
      item.isSelected = selectAll;
    }
    cartItems.refresh(); // Refresh the cartItems list to update the UI
  }

  // Clear all selected items
  void clearSelections() {
    for (var item in cartItems) {
      item.isSelected = false;
    }
    cartItems.refresh(); // Refresh the cartItems list to update the UI
  }
}
