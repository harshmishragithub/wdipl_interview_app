import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/test1/contt2.dart';
import 'package:wdipl_interview_app/test1/quest22.dart';
import 'package:wdipl_interview_app/test1/quizzpage22.dart';
import 'package:wdipl_interview_app/test1/score22.dart';

class TestSummaryPage extends StatelessWidget {
  final QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Test ${quizController.currentTestIndex.value + 1} Summary",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "You scored ${quizController.testScores.last} out of ${questions.length} on this test.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (quizController.currentTestIndex.value <
                    quizController.totalTests - 1) {
                  quizController
                      .startTest(quizController.currentTestIndex.value + 1);
                } else {
                  Get.to(() => QuizPage());
                }
              },
              child: Text("Proceed to Next Test Part"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => ScorePage());
              },
              child: Text("View Final Score"),
            ),
          ],
        ),
      ),
    );
  }
}
