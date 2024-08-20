import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonDecode
import 'package:wdipl_interview_app/test5/score6.dart';
import 'package:wdipl_interview_app/test5/thanku6.dart';
import '../model/getlogicmodel.dart';

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

  // Store the quiz data from GetLogicModel
  Rx<GetLogicModel> quizData = GetLogicModel().obs;

  // Method to fetch data from the backend
  Future<void> fetchQuizData() async {
    const String apiUrl =
        'https://your-backend-api.com/quiz-data'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        quizData.value = GetLogicModel.fromJson(jsonData);
        currentQuestionIndex.value = 0;
        score.value = 0;
        selectedAnswerIndex.value = -1;
      } else {
        // Handle non-200 responses
        print('Failed to load quiz data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching quiz data: $e');
    }
  }

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
    var currentQuestion = quizData.value.data![currentQuestionIndex.value];

    // Only add to score if a valid answer was selected (not "I don't remember")
    if (selectedAnswerIndex.value != dontRememberIndex &&
        currentQuestion.answer![selectedAnswerIndex.value].isRight == 1) {
      score.value++;
    }

    selectedAnswerIndex.value = -1;

    if (currentQuestionIndex.value < quizData.value.data!.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage5());
    }
  }

  void skipQuestion() {
    selectedAnswerIndex.value = -1;
    if (currentQuestionIndex.value < quizData.value.data!.length - 1) {
      currentQuestionIndex.value++;
      startTimer();
    } else {
      countdownTimer?.cancel();
      testScores.add(score.value);
      Get.to(() => ThankYouPage5());
    }
  }

  Future<void> submitResults() async {
    // Implement your API call here to submit the results

    currentTestIndex.value = 0;
    currentQuestionIndex.value = 0;
    testScores.clear();

    Get.to(() => ScorePage5());
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }
}
