import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/repos/userdet_api.dart';

import '../model/getemhmodel.dart';
import 'thanku.dart';

class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = (-1).obs;
  var score = 0.obs;
  var timer = 60.obs;
  Timer? countdownTimer;
  var currentTestIndex = 0.obs;
  var isLoading = false.obs;
  var isNextButtonEnabled = true.obs; // Flag to control button state
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
    isNextButtonEnabled.value = true;

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
    isLoading.value = true;

    try {
      ResponseData response =
          await PersonalInfoAPIServices().getTechnologyQuestion();

      if (response.status == ResponseStatus.SUCCESS && response.data != null) {
        var questionModel = GetEMHTest.fromJson(response.data);

        if (questionModel.data != null && questionModel.data!.isNotEmpty) {
          var filteredQuestions =
              questionModel.data!.where((q) => q.difficulty == '1').toList();

          questions.clear();
          questions.addAll(filteredQuestions);

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
      isLoading.value = false;
    }
  }

  void submitAnswerAndNext() async {
    isNextButtonEnabled.value = false; // Disable the button on first click

    final selectedAnswer = selectedAnswerIndex.value != dontRememberIndex &&
            selectedAnswerIndex.value != -1
        ? questions[currentQuestionIndex.value]
            .answer![selectedAnswerIndex.value]
        : null;

    if (selectedAnswer != null && selectedAnswer.isRight == '1') {
      score.value++;
    }

    await sendAnswerData(selectedAnswer);

    selectedAnswerIndex.value = -1;

    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      isNextButtonEnabled.value = true; // Re-enable for the next question
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage());
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
        submitAnswerAndNext();
      }
    });
  }
}
