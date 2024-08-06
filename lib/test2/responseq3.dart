// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wdipl_interview_app/test1/contt2.dart';
// import 'package:wdipl_interview_app/test1/score22.dart';

// class ResponseSubmittedPage extends StatelessWidget {
//   final QuizController quizController = Get.find<QuizController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Response Submitted"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Thank you for submitting your responses!",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Click the button below to start the next part of the test.",
//               style: TextStyle(fontSize: 18),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (quizController.currentTestIndex.value <
//                     quizController.totalTests - 1) {
//                   quizController
//                       .startTest(quizController.currentTestIndex.value + 1);
//                 } else {
//                   Get.to(() => ScorePage());
//                 }
//               },
//               child: Text(
//                   "Start Test Part ${quizController.currentTestIndex.value + 2}"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
