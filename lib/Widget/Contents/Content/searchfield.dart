import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final List<dynamic> products;

  const SearchPage({super.key, required this.products});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products; // Initialize with all products
  }

  void _filterProducts(String query) {
    final filtered = widget.products.where((product) {
      final name = product['name'].toLowerCase();
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery); // Case-insensitive search
    }).toList();

    setState(() {
      filteredProducts = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Custom Search TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  _filterProducts(value); // Filter products as user types
                  // ignore: avoid_print
                  print("Searching: $value");
                },
                decoration: const InputDecoration(
                  prefixIcon: ImageIcon(AssetImage("assets/Search.png")),
                  hintText: 'Search here ...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Display filtered products
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ListTile(
                    title: Text(product['name']),
                    subtitle: Text('\$${product['price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
