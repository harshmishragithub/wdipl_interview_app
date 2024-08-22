import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/repos/userdet_api.dart';
import 'package:wdipl_interview_app/test1/thanku.dart';
import 'package:wdipl_interview_app/test2/thanku3.dart';

import '../model/getemhmodel.dart';

class QuizController2 extends GetxController {
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
          // Filter questions with difficulty level "2"
          var filteredQuestions =
              questionModel.data!.where((q) => q.difficulty == '2').toList();

          // Clear and add the filtered questions to the list
          questions.clear();
          questions.addAll(filteredQuestions);

          log('Questions fetched: ${questions.length}' as num);
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
        log((response.message ?? 'Failed to fetch questions') as num);
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to fetch questions',
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
    if (selectedAnswerIndex.value != dontRememberIndex &&
        questions[currentQuestionIndex.value]
                .answer![selectedAnswerIndex.value]
                .isRight ==
            '1') {
      score.value++;
    }

    await sendAnswerData();

    selectedAnswerIndex.value = -1;

    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage2());
    }
  }

  Future<void> sendAnswerData() async {
    final questionId = questions[currentQuestionIndex.value].id;
    final selectedAnswer = selectedAnswerIndex.value != dontRememberIndex
        ? questions[currentQuestionIndex.value]
            .answer![selectedAnswerIndex.value]
        : null;

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
