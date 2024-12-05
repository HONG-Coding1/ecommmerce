import 'package:ecommerce/Widget/Contents/Content/searchfield.dart';
import 'package:ecommerce/Widget/Contents/Home/banner_slider.dart';
import 'package:ecommerce/Widget/Contents/Home/product_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<dynamic> products = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/products'));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  void _filterProducts(String query) {
    final filtered = products.where((product) {
      final name = product['name'].toLowerCase();
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery); // Case-insensitive search
    }).toList();

    setState(() {
      products = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Search TextField
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: TextField(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(products: products),
                      ),
                    );
                  },
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
            ),
            // BannerSlider and Product List
            const BannerSlider(),
            ProductList(products: products),
          ],
        ),
      ),
    );
  }
}
