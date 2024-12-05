import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> banners = [
      Center(
        child: Image.asset(
          width: double.infinity, // Fill width of container
          height: double.infinity, // Fill height of container
          "assets/banner1.png",
          fit: BoxFit.fill, // This stretches the image to fit the container
        ),
      ),
      Center(
        child: Image.asset(
          "assets/banner1.png",
          width: double.infinity, // Fill width of container
          height: double.infinity, // Fill height of container
          fit: BoxFit.fill, // Ensure the image covers the area
        ),
      ),
      Center(
        child: Image.asset(
          "assets/banner1.png",
          width: double.infinity, // Fill width of container
          height: double.infinity, // Fill height of container
          fit: BoxFit.fill, // Ensure the image covers the area
        ),
      ),
    ];

    return Container(
      color: Colors.white,
      child: SizedBox(
        height: 200,
        child: PageView(
          children: banners,
        ),
      ),
    );
  }
}
