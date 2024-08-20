import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wdipl_interview_app/test5/thanku6.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/getpermodel.dart';

// Assuming you will adapt this file for dynamic questions.

class QuizController5 extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = (-1).obs;
  var score = 0.obs;
  var timer = 60.obs;
  Timer? countdownTimer;
  var currentTestIndex = 0.obs;
  List<int> testScores = [];
  final int totalTests = 5;
  final List<Data> questions =
      <Data>[].obs; // List of questions fetched from API

  // Option index for "I don't remember"
  final int dontRememberIndex = -2;

  void startTest(int testIndex) async {
    currentTestIndex.value = testIndex;
    currentQuestionIndex.value = 0;
    score.value = 0;
    selectedAnswerIndex.value = -1;

    await fetchQuestions(); // Fetch questions before starting the timer
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

  Future<void> fetchQuestions() async {
    try {
      var response = await http.get(Uri.parse(
          'http://192.168.50.78/laravel_test/public/api/get_personality_que_ans'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        GetPersonalQModel questionModel =
            GetPersonalQModel.fromJson(jsonResponse);

        questions.assignAll(questionModel.data ?? []);

        // Optional: Provide feedback for successful data fetching
        print('Questions fetched successfully.');
      } else {
        _showSnackBar(
            'Failed to fetch questions. Status code: ${response.statusCode}',
            Colors.red);
      }
    } catch (e) {
      _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
      print('Error fetching questions: $e');
    }
  }

  void _showSnackBar(String message, Color color) {
    Get.snackbar('Error', message,
        backgroundColor: color, colorText: Colors.white);
  }

  void submitAnswerAndNext() async {
    if (selectedAnswerIndex.value != dontRememberIndex) {
      var correctAnswerIndex = questions[currentQuestionIndex.value]
          .answer!
          .indexWhere((answer) => answer.isRight == 1);

      if (selectedAnswerIndex.value == correctAnswerIndex) {
        score.value++;
      }

      // Send data to the server
      await submitResultToServer(
        principalXid: "73",
        pesonalityQuestionXid:
            questions[currentQuestionIndex.value].id.toString(),
        pesonalityAnswerXid: questions[currentQuestionIndex.value]
            .answer![selectedAnswerIndex.value]
            .id
            .toString(),
        isRight: selectedAnswerIndex.value == correctAnswerIndex ? "1" : "0",
      );
    }

    selectedAnswerIndex.value = -1;

    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage5());
    }
  }

  Future<void> submitResultToServer({
    required String principalXid,
    required String pesonalityQuestionXid,
    required String pesonalityAnswerXid,
    required String isRight,
  }) async {
    try {
      Map<String, dynamic> submissionData = {
        "principal_xid": principalXid,
        "question_id": pesonalityQuestionXid,
        "answer_id": pesonalityAnswerXid,
        "is_right": isRight,
        "updated_at": DateTime.now().toIso8601String(),
        "created_at": DateTime.now().toIso8601String(),
      };

      var response = await http.post(
        Uri.parse('your_api_submission_endpoint_here'),
        body: json.encode(submissionData),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201) {
        // Handle successful submission, for example:
        _showSnackBar('Data submitted successfully!', Colors.green);
      } else {
        _showSnackBar(
            'Failed to submit data. Status code: ${response.statusCode}',
            Colors.red);
      }
    } catch (e) {
      _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
      print('Error submitting data: $e');
    }
  }

  void skipQuestion() {
    selectedAnswerIndex.value = -1;
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage5());
    }
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }
}
