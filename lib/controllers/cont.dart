// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';

// import 'package:wdipl_interview_app/models/quest.dart';

// import 'package:wdipl_interview_app/screens/components/testovervi.dart';
// import 'package:wdipl_interview_app/screens/score/score_screen.dart';

// class QuestionController extends GetxController
//     with SingleGetTickerProviderMixin {
//   late AnimationController _animationController;
//   late Animation _animation;
//   Animation get animation => this._animation;

//   late PageController _pageController;
//   PageController get pageController => this._pageController;

//   List<Question> _questions = [];
//   List<Question> get questions => this._questions;

//   bool _isAnswered = false;
//   bool get isAnswered => this._isAnswered;

//   late int _correctAns;
//   int get correctAns => this._correctAns;

//   late int _selectedAns;
//   int get selectedAns => this._selectedAns;

//   RxInt _questionNumber = 1.obs;
//   RxInt get questionNumber => this._questionNumber;

//   RxInt _numOfCorrectAns = 0.obs;
//   RxInt get numOfCorrectAns => this._numOfCorrectAns;

//   int _currentTest = 0;
//   final int totalTests = 5;

//   final List<List<Question>> allTests = [
//     sampleData1,
//     sampleData2,
//     sampleData3,
//     sampleData4,
//     sampleData5,
//   ];

//   @override
//   void onInit() {
//     super.onInit();
//     _startNewTest();
//   }

//   void _startNewTest() {
//     _questions = allTests[_currentTest];
//     _animationController =
//         AnimationController(duration: Duration(seconds: 60), vsync: this);
//     _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
//       ..addListener(() {
//         update();
//       });

//     _animationController
//         .forward()
//         .whenComplete(() => nextQuestion(Get.context!));
//     _pageController = PageController();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     _animationController.dispose();
//     _pageController.dispose();
//   }

//   void checkAns(Question question, int selectedIndex, BuildContext context) {
//     _isAnswered = true;
//     _correctAns = question.answer;
//     _selectedAns = selectedIndex;

//     if (_correctAns == _selectedAns) _numOfCorrectAns++;

//     _animationController.stop();
//     update();

//     Future.delayed(Duration(seconds: 3), () {
//       nextQuestion(context);
//     });
//   }

//   void nextQuestion(BuildContext context) {
//     if (_questionNumber.value != _questions.length) {
//       _isAnswered = false;
//       _pageController.nextPage(
//           duration: Duration(milliseconds: 250), curve: Curves.ease);

//       _animationController.reset();
//       _animationController.forward().whenComplete(() => nextQuestion(context));
//     } else if (_currentTest < totalTests - 1) {
//       _currentTest++;
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) =>
//               TestOverviewScreen(testNumber: _currentTest + 1),
//         ),
//       );
//     } else {
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => ScoreScreen(),
//       ));
//     }
//   }

//   void updateTheQnNum(int index) {
//     _questionNumber.value = index + 1;
//   }
// }
