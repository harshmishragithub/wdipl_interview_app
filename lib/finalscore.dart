// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wdipl_interview_app/test1/contt2.dart';

// class FinalScorePage extends StatelessWidget {
//   final QuizController quizController = Get.find<QuizController>();

//   @override
//   Widget build(BuildContext context) {
//     var tests;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Final Score"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Congratulations!",
//               style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "You completed all tests!",
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Your total score is: ${quizController.score.value}/${tests.length * tests[0].questions.length}",
//               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Get.offAll(() => TestOverviewPage());
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text("Retry All Tests", style: TextStyle(fontSize: 18)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
