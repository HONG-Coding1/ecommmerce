import 'package:ecommerce/Authentication/auth/signinpage.dart';
import 'package:ecommerce/Authentication/controller/controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registerpage extends StatelessWidget {
  Registerpage({super.key});

  final authCtr = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Sign Up here...",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                TextField(
                  controller: authCtr.ctrEmail,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Enter Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: authCtr.ctrPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Enter Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: authCtr.ctrConfirmPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () async {
                    if (authCtr.ctrPassword.text ==
                        authCtr.ctrConfirmPassword.text) {
                      // Perform sign-up
                      await authCtr.signup();
                    } else {
                      // Show error message
                      Get.snackbar("Error", "Passwords do not match.");
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Rounded corners with radius of 12
                    ),
                    side: const BorderSide(
                      color: Colors.blue, // Border color
                      width: 2.0, // Border width
                    ),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 157, vertical: 16),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const Center(
                  child: Text(
                    "Or Continue with ______",
                    style: TextStyle(
                      wordSpacing: 3,
                      color: Color.fromARGB(
                        98,
                        51,
                        50,
                        50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distribute buttons evenly
                  children: [
                    TextButton(
                      onPressed: () {
                        // Action for the first button
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Set the background to white
                        minimumSize: const Size(
                            80, 40), // Set width to 80 and height to 40
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(6), // 6px rounded corners
                        ),
                      ),
                      child: Image.asset(
                        'assets/google.png',
                        width: 80, // Match the width of the button
                        height: 40, // Match the height of the button
                        fit: BoxFit
                            .contain, // Scale the image to fit within the button without distortion
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Action for the second button
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Set the background to white
                        minimumSize: const Size(
                            80, 40), // Set width to 80 and height to 40
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(6), // 6px rounded corners
                        ),
                      ),
                      child: Image.asset(
                        'assets/apple.png',
                        width: 80, // Match the width of the button
                        height: 40, // Match the height of the button
                        fit: BoxFit
                            .contain, // Scale the image to fit within the button without distortion
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Action for the third button
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Set the background to white
                        minimumSize: const Size(
                            80, 40), // Set width to 80 and height to 40
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(6), // 6px rounded corners
                        ),
                      ),
                      child: Image.asset(
                        'assets/facebook.png',
                        width: 80, // Match the width of the button
                        height: 40, // Match the height of the button
                        fit: BoxFit
                            .contain, // Scale the image to fit within the button without distortion
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text:
                          "If you already have an account\n you can ", // First line of the sentence
                      style: const TextStyle(
                          color: Colors.black, // Text color
                          fontSize: 20,
                          fontWeight: FontWeight.w500 // Font size
                          ),
                      children: [
                        TextSpan(
                          text:
                              'Log in here ! ', // Interactive part on the second line
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 94,
                                255), // Color for the clickable text
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to the registration page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signinpage()),
                              );
                            },
                        ),
                      ],
                    ),
                    textAlign:
                        TextAlign.center, // Align text to the center (optional)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
