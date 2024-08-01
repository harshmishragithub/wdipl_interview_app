// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wdipl_interview_app/constants.dart';
// import 'package:wdipl_interview_app/controllers/cont.dart';
// import 'package:wdipl_interview_app/screens/components/pro.dart';
// import 'package:wdipl_interview_app/screens/components/questioncard.dart';

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     QuestionController _questionController = Get.put(QuestionController());
//     return Stack(
//       children: [
//         SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                 child: ProgressBar(),
//               ),
//               SizedBox(height: kDefaultPadding),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                 child: Obx(
//                   () => Text.rich(
//                     TextSpan(
//                       text:
//                           "Question ${_questionController.questionNumber.value}",
//                       style: TextStyle(color: kSecondaryColor),
//                       children: [
//                         TextSpan(
//                           text: "/${_questionController.questions.length}",
//                           style: TextStyle(color: kSecondaryColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Divider(thickness: 1.5),
//               SizedBox(height: kDefaultPadding),
//               Expanded(
//                 child: PageView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   controller: _questionController.pageController,
//                   onPageChanged: _questionController.updateTheQnNum,
//                   itemCount: _questionController.questions.length,
//                   itemBuilder: (context, index) => QuestionCard(
//                       question: _questionController.questions[index]),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
