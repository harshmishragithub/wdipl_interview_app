import 'package:get/get.dart';

class QuizController5 extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = (-1).obs;
  var timer = 60.obs;

  void startTimer() {
    // Your timer logic
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
    // Additional logic to handle answer selection
  }

  void skipQuestion() {
    if (currentQuestionIndex.value < 4) {
      currentQuestionIndex.value++;
      selectedAnswerIndex.value = -1; // Reset selection
      timer.value = 60; // Reset the timer
      startTimer();
    } else {
      // Navigate to the score page or end of quiz logic
    }
  }
}
