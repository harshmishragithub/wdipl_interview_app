import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/test3/quest4.dart';
import 'package:wdipl_interview_app/test3/skip4.dart';
import 'package:wdipl_interview_app/testoverview/testov4.dart';

class ThankYouPage3 extends StatelessWidget {
  final QuizController3 quizController = Get.find<QuizController3>();

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
              "Your Score: ${quizController.testScores.last} / ${question3s.length}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => UpcomingTestPage4());
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
