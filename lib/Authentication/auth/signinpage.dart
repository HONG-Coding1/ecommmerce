// ignore_for_file: avoid_print

import 'package:ecommerce/Authentication/auth/registerpage.dart';
import 'package:ecommerce/Authentication/controller/controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signinpage extends StatelessWidget {
  Signinpage({super.key});

  final authCtr = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back(); // Use GetX for navigation instead of Navigator.pop
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              Colors.blue.withOpacity(0.2),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              children: [
                const SizedBox(height: 90),
                const Text(
                  "Sign In to recharge Direct",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 70),
                TextField(
                  controller: authCtr.ctrEmail,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Enter Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: authCtr.ctrPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Enter Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Add recover password logic here
                      },
                      child: const Text(
                        "Recover Password?",
                        style: TextStyle(
                          color: Color.fromARGB(98, 51, 50, 50),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    await authCtr.signin();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 160, vertical: 16),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    "Or Continue with",
                    style: TextStyle(
                      color: Color.fromARGB(98, 51, 50, 50),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _socialButton(
                      'google.png',
                      () => authCtr.signInWithGoogle(),
                    ),
                    _socialButton(
                      'apple.png',
                      () {
                        print("Apple Sign-In clicked");
                      },
                    ),
                    _socialButton(
                      'facebook.png',
                      () {
                        print("Facebook Sign-In clicked");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "If you don't have an account\n you can ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: 'Register here!',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 94, 255),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => Registerpage());
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable social button widget with action
  Widget _socialButton(String imageName, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size(80, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Image.asset(
        'assets/$imageName',
        width: 80,
        height: 40,
        fit: BoxFit.contain,
      ),
    );
  }
}
