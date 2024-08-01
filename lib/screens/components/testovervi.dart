import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/controllers/contt2.dart';

import 'package:wdipl_interview_app/quizzpage22.dart';

class TestOverviewPage extends StatelessWidget {
  final List<String> testDescriptions = [
    "Test 1: Basic Math Questions",
    "Test 2: General Knowledge",
    "Test 3: Science and Nature",
    "Test 4: History and Culture",
    "Test 5: Technology and Innovation",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Overview'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: testDescriptions.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(testDescriptions[index]),
                trailing: ElevatedButton(
                  onPressed: () {
                    Get.find<QuizController>().startTest(index);
                    Get.to(() => QuizPage());
                  },
                  child: Text('Start Test ${index + 1}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
