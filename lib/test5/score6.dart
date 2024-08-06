import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/test5/contt6.dart';
import 'package:wdipl_interview_app/test5/quest6.dart';

class ScorePage5 extends StatelessWidget {
  final QuizController5 quizController = Get.find<QuizController5>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Score"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Congratulations!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "You completed all tests!",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              "Your total score is: ${quizController.testScores.reduce((a, b) => a + b)} / ${quizController.totalTests * question5s.length}",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                quizController.startTest(0);
                // Get.offAll(() => Testov1());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Retry All Tests", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
