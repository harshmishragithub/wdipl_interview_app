import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'contt6.dart'; // Import the animation package

class ThankYouPage5 extends StatelessWidget {
  final QuizController5 quizController = Get.find<QuizController5>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Thank You",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff3e474d), // Custom AppBar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff3e474d), Color(0xFF52eefd)],
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
                SizedBox(height: 40),
                FadeInUp(
                  duration: Duration(milliseconds: 1400),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add navigation or another action here
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF2d84b6),
                      backgroundColor: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
