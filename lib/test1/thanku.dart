import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/test1/contt2.dart';

import 'package:wdipl_interview_app/testoverview/testov2.dart';

class ThankYouPage extends StatelessWidget {
  final QuizController quizController = Get.find<QuizController>();

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
            colors: [
              Color(0xff3e474d),
              Color(0xFFf0413f),
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
                    Get.offAll(() => UpcomingTestPage2());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Start Test Part 2",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFf0413f),
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
