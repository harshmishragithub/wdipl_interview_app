import 'package:get/get.dart';
import 'dart:async';

import 'package:wdipl_interview_app/test1/quest22.dart';
import 'package:wdipl_interview_app/test1/score22.dart';
import 'package:wdipl_interview_app/test1/testover.dart';

class QuizController extends GetxController {
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
    countdownTimer?.cancel(); // Cancel any previous timer
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        submitAnswerAndNext();
      }
    });
  }

  void submitAnswerAndNext() {
    // Check if the selected answer is correct
    if (selectedAnswerIndex.value ==
        questions[currentQuestionIndex.value].correctAnswerIndex) {
      score.value++;
    }
    selectedAnswerIndex.value = -1; // Reset selection

    // Proceed to the next question or navigate to the summary page
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => TestSummaryPage());
    }
  }

  void skipQuestion() {
    selectedAnswerIndex.value = -1; // Reset selection
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer(); // Reset timer for the next question
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => TestSummaryPage());
    }
  }

  Future<void> submitResults() async {
    final results = {
      "testScores": testScores,
      "totalScore": testScores.reduce((a, b) => a + b),
    };

    // Implement your API call here to submit the results

    // Reset the test state
    currentTestIndex.value = 0;
    currentQuestionIndex.value = 0;
    testScores.clear();

    // Navigate to the Score Page
    Get.to(() => ScorePage());
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }
}
