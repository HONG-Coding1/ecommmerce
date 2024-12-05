import 'package:ecommerce/Authentication/auth/authpage.dart';
import 'package:ecommerce/Widget/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final ctrEmail = TextEditingController();
  final ctrPassword = TextEditingController();
  final ctrConfirmPassword =
      TextEditingController(); // Added controller for confirm password
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign Up method
  Future<void> signup() async {
    String email = ctrEmail.text.trim();
    String password = ctrPassword.text.trim();
    String confirmPassword = ctrConfirmPassword.text.trim();

    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        try {
          final userCredential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          if (userCredential.user != null) {
            Get.snackbar("Authentication", "Successfully Registered");
            Get.to(() => const MainApp());
          }
        } on FirebaseAuthException catch (e) {
          Get.snackbar("Authentication", e.message ?? "An error occurred");
        }
      } else {
        Get.snackbar("Authentication", "Passwords do not match");
      }
    } else {
      Get.snackbar('Authentication', "Please enter all fields");
    }
  }

  // Sign In method
  Future<void> signin() async {
    String email = ctrEmail.text.trim();
    String password = ctrPassword.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          Get.snackbar("Authentication", "Welcome back!");
          Get.to(() => const MainApp());
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Authentication", e.message ?? "An error occurred");
      }
    } else {
      Get.snackbar('Authentication', "Please enter a valid email and password");
    }
  }

  // Google Sign-In method
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar("Google Sign-In", "Sign-in canceled");
        return;
      }

      // Obtain the authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        Get.snackbar("Google Sign-In", "Successfully Signed In");
        Get.to(() => const MainApp());
      }
    } catch (e) {
      Get.snackbar("Google Sign-In", "Error: $e");
    }
  }

  // Sign-Out method

  Future<void> signOut() async {
    try {
      // Sign out from Firebase Authentication
      await FirebaseAuth.instance.signOut();

      // Sign out from Google Sign-In
      await GoogleSignIn().signOut();

      // Show success message
      Get.snackbar("Sign-Out", "Successfully signed out");
      await Future.delayed(const Duration(seconds: 2));
      Get.to(() => const Authpage());
    } catch (e) {
      // Show error message if something goes wrong
      Get.snackbar("Sign-Out", "Error: $e");
    }
  }
}
