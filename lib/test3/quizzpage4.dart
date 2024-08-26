import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contt4.dart';

class QuizzPage3 extends StatelessWidget {
  final QuizController3 quizController = Get.put(QuizController3());

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
                fontWeight: FontWeight.bold,
              ),
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
                // Animated question container
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey<int>(
                        quizController.currentQuestionIndex.value),
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
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Enhanced Firecracker fuse animation
                Obx(() {
                  double progress = quizController.timer.value / 60.0;
                  return Stack(
                    children: [
                      // Fuse base (Black)
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      // Burning fuse effect with a spark
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: 8,
                        width: MediaQuery.of(context).size.width * progress,
                        decoration: BoxDecoration(
                          color: Color(0xff246c9c),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 21, 151, 198)
                                  .withOpacity(0.8),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff246c9c),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 32, 176, 208)
                                      .withOpacity(0.8),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Center(
                              child: AnimatedOpacity(
                                opacity: progress > 0 ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 300),
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        const Color.fromARGB(255, 94, 210, 252),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
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
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color.fromARGB(255, 95, 180, 230)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: isSelected
                                    ? Border.all(color: Color(0xFF93fcff))
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  "I don't remember",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color.fromARGB(255, 95, 180, 230)
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
                                      fontWeight: FontWeight.bold,
                                    ),
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
                  AnimatedScale(
                    scale: 1.0,
                    duration: Duration(milliseconds: 300),
                    child: ElevatedButton(
                      onPressed: () {
                        quizController.submitAnswerAndNext();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2c94c1),
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
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
