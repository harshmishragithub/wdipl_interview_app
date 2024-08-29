import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'contt6.dart'; // Import the animation package
// Import the WelcomeScreen widget

class ThankYouPage5 extends StatelessWidget {
  final QuizController5 quizController = Get.find<QuizController5>();

  ThankYouPage5() {
    _clearPreferencesAndRedirect();
  }

  Future<void> _clearPreferencesAndRedirect() async {
    // Clear shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Show confirmation message using Snackbar
    Get.snackbar(
      "Preferences Cleared",
      "All saved data has been removed.",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );

    // Automatically redirect to WelcomeScreen after 3 seconds
    await Future.delayed(Duration(seconds: 3));
    Get.offAll(() => WelcomeScreen()); // Navigate to WelcomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Thank You",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFe21f88), // Custom AppBar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe21f88), Color(0xFF52eefd)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInDown(
                  duration: Duration(milliseconds: 800),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                SizedBox(height: 30),
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Text(
                    "Thank you for your response!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                FadeInUp(
                  duration: Duration(milliseconds: 1200),
                  child: Text(
                    "Assessment completed successfully!",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white70,
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
}
