import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/test1/contt2.dart';
import 'package:wdipl_interview_app/test1/quizzpage22.dart';

class TestOverviewPage extends StatelessWidget {
  final QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Overview"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Test ${quizController.currentTestIndex.value + 1} Overview",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "You are about to start the test. Please read the instructions carefully.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                quizController.startTest(quizController.currentTestIndex.value);
                Get.to(() => QuizPage());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Start Test",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
