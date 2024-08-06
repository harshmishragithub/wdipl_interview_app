import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/test2/contt3.dart';
import 'package:wdipl_interview_app/test2/quest3.dart';

import 'package:wdipl_interview_app/testoverview/testov3.dart';

class ThankYouPage2 extends StatelessWidget {
  final QuizController2 quizController = Get.find<QuizController2>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thank You"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thank you for your response!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Your Score: ${quizController.testScores.last} / ${question2.length}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => UpcomingTestPage3());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Return to Overview", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
