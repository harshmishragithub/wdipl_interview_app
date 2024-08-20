import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wdipl_interview_app/test2/contt3.dart';
import 'package:wdipl_interview_app/test2/quest3.dart';

class QuizPage2 extends StatelessWidget {
  final QuizController2 quizController = Get.put(QuizController2());

  @override
  Widget build(BuildContext context) {
    quizController.startTimer();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Obx(() {
          return Text(
            "Question ${quizController.currentQuestionIndex.value + 1}/5",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          );
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              // Implement help or hint functionality
            },
          ),
        ],
      ),
      body: Obx(() {
        final question = question2[quizController.currentQuestionIndex.value];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xff508C9B),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    question.question2Text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  LinearProgressIndicator(
                    value: quizController.timer.value / 60.0,
                    backgroundColor: Color.fromARGB(255, 170, 237, 255),
                    color: Color(0xFF134B70),
                    minHeight: 5,
                  ),
                  Positioned(
                    right: 0,
                    child: Text(
                      "${quizController.timer.value}s",
                      style: TextStyle(
                          color: Color(0xff508C9B),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      question.answers.length + 1, // +1 for "I don't remember"
                  itemBuilder: (context, index) {
                    if (index == question.answers.length) {
                      // The "I don't remember" option
                      return GestureDetector(
                        onTap: () {
                          quizController
                              .selectAnswer(quizController.dontRememberIndex);
                        },
                        child: Obx(() {
                          bool isSelected =
                              quizController.selectedAnswerIndex.value ==
                                  quizController.dontRememberIndex;
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color.fromARGB(255, 119, 186, 232)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              border: isSelected
                                  ? Border.all(
                                      color: Color.fromARGB(255, 119, 186, 232),
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                "I don't remember",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }),
                      );
                    } else {
                      final answer = question.answers[index];
                      return GestureDetector(
                        onTap: () {
                          quizController.selectAnswer(index);
                        },
                        child: Obx(() {
                          bool isSelected =
                              quizController.selectedAnswerIndex.value == index;
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color.fromARGB(255, 119, 186, 232)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              border: isSelected
                                  ? Border.all(
                                      color: Color.fromARGB(255, 119, 186, 232),
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  String.fromCharCode(65 +
                                      index), // Converts 0 -> A, 1 -> B, etc.
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    answer,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: Color.fromARGB(255, 119, 186, 232),
                                  ),
                              ],
                            ),
                          );
                        }),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              if (quizController.selectedAnswerIndex.value != -1)
                ElevatedButton(
                  onPressed: () {
                    quizController.submitAnswerAndNext();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF134B70),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
