import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/model/getemhmodel.dart';
import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/repos/userdet_api.dart';
import 'package:wdipl_interview_app/test1/thanku.dart';

class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = (-1).obs;
  var score = 0.obs;
  var timer = 60.obs;
  Timer? countdownTimer;
  var currentTestIndex = 0.obs;
  var isLoading = false.obs;
  List<int> testScores = [];
  final int totalTests = 5;
  final int dontRememberIndex = -2;

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

    await fetchQuestions();

    if (questions.isNotEmpty) {
      startTimer();
    } else {
      log('No questions available' as num);
      Get.snackbar(
        'Error',
        'No questions available',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> fetchQuestions() async {
    isLoading.value = true;

    try {
      // Fetch data from the API
      ResponseData response =
          await PersonalInfoAPIServices().getTechnologyQuestion();

      // Check if the response is successful and contains data
      if (response.status == ResponseStatus.SUCCESS && response.data != null) {
        // Parse the response data into the GetEMHTest model
        var questionModel = GetEMHTest.fromJson(response.data);

        // Check if the model's data field is not null
        if (questionModel.data != null && questionModel.data!.isNotEmpty) {
          // Filter questions with difficulty level "1"
          var filteredQuestions =
              questionModel.data!.where((q) => q.difficulty == '1').toList();

          // Clear and add the filtered questions to the list
          questions.clear();
          questions.addAll(filteredQuestions);

          Get.snackbar(
            'Success',
            'Questions fetched successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          log('No questions found in the response' as num);
          Get.snackbar(
            'Error',
            'No questions found in the response',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        log(response.message as num);
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('An error occurred: ${e.toString()}' as num);
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void submitAnswerAndNext() async {
    // Fetch the selected answer based on the current index
    final selectedAnswer = selectedAnswerIndex.value != dontRememberIndex &&
            selectedAnswerIndex.value != -1
        ? questions[currentQuestionIndex.value]
            .answer![selectedAnswerIndex.value]
        : null;

    // Check if the answer is correct and update the score
    if (selectedAnswer != null && selectedAnswer.isRight == '1') {
      score.value++;
    }

    // Send the selected answer data to the server or process it further
    await sendAnswerData(selectedAnswer);

    // Reset the selected answer index
    selectedAnswerIndex.value = -1;

    // Check if there are more questions to proceed to the next one
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer(); // Start the timer for the next question
    } else {
      // If all questions are answered, stop the timer and navigate to the Thank You page
      countdownTimer?.cancel();
      testScores.add(score.value); // Store the score
      Get.to(() => ThankYouPage()); // Navigate to the Thank You page
    }
  }

  Future<void> sendAnswerData(Answer? selectedAnswer) async {
    final questionId = questions[currentQuestionIndex.value].id;

    Map<String, dynamic> answerData = {
      "question_id": questionId.toString(),
      "answer_id": selectedAnswer?.id?.toString(),
    };

    ResponseData response =
        await PersonalInfoAPIServices().sendTechnoQuestion(answerData);

    if (response.status == ResponseStatus.SUCCESS) {
      print('Data Saved Successfully.');
    } else {
      print('Failed to save data');
    }
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
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
}
