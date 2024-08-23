import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/test2/contt3.dart';

class QuizzPage2 extends StatelessWidget {
  final QuizController2 quizController = Get.put(QuizController2());

  @override
  Widget build(BuildContext context) {
    quizController.startTest(quizController.currentTestIndex.value);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFfefffe),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Obx(() {
            return Text(
              "Question ${quizController.currentQuestionIndex.value + 1}/${quizController.questions.length}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            );
          }),
          actions: [
            IconButton(
              icon: Icon(Icons.help_outline, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Obx(() {
          if (quizController.questions.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          final question = quizController
              .questions[quizController.currentQuestionIndex.value];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xff3e474d),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      question.question!,
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
                      color: Color(0xFFf0413f),
                      minHeight: 5,
                    ),
                    Positioned(
                      right: 0,
                      child: Text(
                        "${quizController.timer.value}s",
                        style: TextStyle(
                            color: Color(0xFFf0413f),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: question.answer!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == question.answer!.length) {
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
                                    ? Color.fromARGB(255, 227, 133, 132)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: isSelected
                                    ? Border.all(color: Colors.black)
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  "I don't remember",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                        );
                      } else {
                        final answer = question.answer![index];
                        return GestureDetector(
                          onTap: () {
                            quizController.selectAnswer(index);
                          },
                          child: Obx(() {
                            bool isSelected =
                                quizController.selectedAnswerIndex.value ==
                                    index;
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color.fromARGB(255, 227, 133, 132)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: isSelected
                                    ? Border.all(color: Colors.black)
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    String.fromCharCode(65 + index),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      answer.answere!,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: Color.fromARGB(255, 3, 1, 1),
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
                      backgroundColor: Color(0xFFf0413f),
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 24),
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
      ),
    );
  }
}
