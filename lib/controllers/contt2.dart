import 'package:get/get.dart';
import 'package:wdipl_interview_app/models/quest22.dart';
import 'dart:async';
import 'package:wdipl_interview_app/score22.dart';
import 'package:wdipl_interview_app/screens/components/testovervi.dart';

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
    testScores.clear();
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

    // Proceed to the next question or test
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      // Save the score for this test
      testScores.add(score.value);
      if (currentTestIndex.value < totalTests - 1) {
        countdownTimer?.cancel(); // Cancel the timer when test ends
        Get.to(TestOverviewPage());
      } else {
        submitResults();
        countdownTimer?.cancel();
        Get.to(ScorePage());
      }
    }
  }

  void skipQuestion() {
    selectedAnswerIndex.value = -1; // Reset selection
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer(); // Reset timer for the next question
    } else {
      testScores.add(score.value);
      if (currentTestIndex.value < totalTests - 1) {
        Get.to(TestOverviewPage());
      } else {
        submitResults();
        countdownTimer?.cancel();
        Get.to(ScorePage());
      }
    }
  }

  Future<void> submitResults() async {
    final results = {
      "testScores": testScores,
      "totalScore": testScores.reduce((a, b) => a + b),
    };

    // Example API call (using http package)
    // final response = await http.post(
    //   Uri.parse("https://yourapi.com/submit-results"),
    //   body: jsonEncode(results),
    //   headers: {"Content-Type": "application/json"},
    // );

    // Handle response from the backend
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }
}
