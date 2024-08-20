import 'dart:async';

import 'package:get/get.dart';
import 'package:wdipl_interview_app/test4/score5.dart';
import 'package:wdipl_interview_app/test4/thanku5.dart';

import 'quest5.dart';

class QuizController4 extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = (-1).obs;
  var score = 0.obs;
  var timer = 60.obs;
  Timer? countdownTimer;
  var currentTestIndex = 0.obs;
  List<int> testScores = [];
  final int totalTests = 5;

  // Option index for "I don't remember"
  final int dontRememberIndex = -2;

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
    // Only add to score if a valid answer was selected (not "I don't remember")
    if (selectedAnswerIndex.value != dontRememberIndex &&
        selectedAnswerIndex.value ==
            question4s[currentQuestionIndex.value].correctAnswerIndex) {
      score.value++;
    }

    selectedAnswerIndex.value = -1;

    if (currentQuestionIndex.value < question4s.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage4());
    }
  }

  void skipQuestion() {
    selectedAnswerIndex.value = -1;
    if (currentQuestionIndex.value < question4s.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage4());
    }
  }

  Future<void> submitResults() async {
    // Implement your API call here to submit the results

    currentTestIndex.value = 0;
    currentQuestionIndex.value = 0;
    testScores.clear();

    Get.to(() => ScorePage4());
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }
}
