import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/repos/userdet_api.dart';
import 'package:wdipl_interview_app/test4/thanku5.dart';
import '../model/getlogicmodel.dart';

class QuizController4 extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = (-1).obs;
  var score = 0.obs;
  var timer = 60.obs;
  Timer? countdownTimer;
  var currentTestIndex = 0.obs;
  var isLoading = false.obs; // Define isLoading
  var isNextButtonEnabled = true.obs; // Flag to control button state
  List<int> testScores = [];
  final int totalTests = 5;
  final int dontRememberIndex = -2;

  // List to hold fetched questions
  List<Data> questions = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  void startTest(int testIndex) async {
    currentTestIndex.value = testIndex;
    currentQuestionIndex.value = 0;
    score.value = 0;
    selectedAnswerIndex.value = -1;
    isNextButtonEnabled.value = true; // Enable button at the start of the test

    // Fetch questions from API
    await fetchQuestions();

    if (questions.isNotEmpty) {
      startTimer();
    } else {
      Get.snackbar(
        'Error',
        'No questions available',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> fetchQuestions() async {
    isLoading.value = true; // Start loading

    try {
      // Fetch data from API
      ResponseData response =
          await PersonalInfoAPIServices().getLogicalQuestion();

      // Check if the response was successful and contains data
      if (response.status == ResponseStatus.SUCCESS && response.data != null) {
        // Parse the response data into the GetLogicModel
        var questionModel = GetLogicModel.fromJson(response.data);

        // Check if the model's data field is not null and contains questions
        if (questionModel.data != null && questionModel.data!.isNotEmpty) {
          questions.clear();
          questions.addAll(questionModel.data!); // Add the fetched questions

          Get.snackbar(
            'Success',
            'Questions fetched successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        } else {
          Get.snackbar(
            'Error',
            'No questions found in the response',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  void startTimer() {
    timer.value = 60;
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        submitAnswerAndNext(); // Time out, submit with null answer
      }
    });
  }

  void submitAnswerAndNext() async {
    isNextButtonEnabled.value = false; // Disable the button on first click

    // Fetch the selected answer based on the current index
    final selectedAnswer = selectedAnswerIndex.value != dontRememberIndex &&
            selectedAnswerIndex.value != -1
        ? questions[currentQuestionIndex.value]
            .answer![selectedAnswerIndex.value]
        : null;

    // Check if the selected answer is correct (using the isRight field)
    if (selectedAnswer != null && selectedAnswer.isRight == 1) {
      score.value++;
    }

    // Send answer data to the server
    await sendAnswerData(selectedAnswer);

    // Reset the selected answer
    selectedAnswerIndex.value = -1;

    // Move to the next question or finish the quiz
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      isNextButtonEnabled.value = true; // Re-enable button for next question
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage4());
    }
  }

  Future<void> sendAnswerData(Answer? selectedAnswer) async {
    final questionId = questions[currentQuestionIndex.value].id;

    // Prepare the answer data payload
    Map<String, dynamic> answerData = {
      "question_id": questionId?.toString(),
      "answer_id": selectedAnswer?.id?.toString(),
    };

    try {
      // Send the answer data to the server
      ResponseData response =
          await PersonalInfoAPIServices().sendLogicalQuestion(answerData);

      if (response.status == ResponseStatus.SUCCESS) {
        print('Data Saved Successfully.');
        // Optionally, handle the response data
      } else {
        print('Failed to save data: ${response.message}');
      }
    } catch (e) {
      print('An error occurred while sending answer data: ${e.toString()}');
    }
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }
}
