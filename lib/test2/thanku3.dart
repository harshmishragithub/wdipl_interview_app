import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../testoverview/testov3.dart';
import 'contt3.dart';

class ThankYouPage2 extends StatelessWidget {
  final QuizController2 quizController = Get.find<QuizController2>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Thank You",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF134B70), // Custom AppBar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF134B70),
              Color(0xff508C9B),
            ],
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
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 100,
                ),
                SizedBox(height: 30),
                Text(
                  "Answer Submitted Successfully!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // Text(
                //   "Your Score: ${quizController.testScores.last} / ${questions.length}",
                //   style: TextStyle(
                //     fontSize: 24,
                //     color: Colors.white70,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => UpcomingTestPage3());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Start Test Part 3",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff508C9B),
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
