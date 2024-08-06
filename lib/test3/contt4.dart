import 'package:get/get.dart';

import 'dart:async';

import 'package:wdipl_interview_app/test3/quest4.dart';
import 'package:wdipl_interview_app/test3/score4.dart';
import 'package:wdipl_interview_app/test3/thanku4.dart';

class QuizController3 extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = (-1).obs;
  var score = 0.obs;
  var timer = 60.obs;
  Timer? countdownTimer;
  var currentTestIndex = 0.obs;
  List<int> testScores = [];
  final int totalTests = 5;

  void startTest(int testIndex) {
    currentTestIndex.value = testIndex;
    currentQuestionIndex.value = 0;
    score.value = 0;
    selectedAnswerIndex.value = -1;
    startTimer();
  }

  void startTimer() {
    timer.value = 60;
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        submitAnswerAndNext();
      }
    });
  }

  void submitAnswerAndNext() {
    if (selectedAnswerIndex.value ==
        question3s[currentQuestionIndex.value].correctAnswerIndex) {
      score.value++;
    }
    selectedAnswerIndex.value = -1;

    if (currentQuestionIndex.value < question3s.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage3());
    }
  }

  void skipQuestion() {
    selectedAnswerIndex.value = -1;
    if (currentQuestionIndex.value < question3s.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage3());
    }
  }

  Future<void> submitResults() async {
    // Implement your API call here to submit the results

    currentTestIndex.value = 0;
    currentQuestionIndex.value = 0;
    testScores.clear();

    Get.to(() => ScorePage3());
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }
}
