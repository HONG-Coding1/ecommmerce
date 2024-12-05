class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  int quantity;
  bool isSelected; // Add the isSelected field

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.isSelected = false, // Default value for isSelected is false
  });
}
