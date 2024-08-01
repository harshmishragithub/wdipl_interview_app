// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wdipl_interview_app/constants.dart';
// import 'package:wdipl_interview_app/controllers/cont.dart';
// import 'package:wdipl_interview_app/models/quest.dart';
// import 'option.dart';

// class QuestionCard extends StatelessWidget {
//   final Question question;

//   const QuestionCard({required this.question});

//   @override
//   Widget build(BuildContext context) {
//     QuestionController _controller = Get.put(QuestionController());
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//       padding: EdgeInsets.all(kDefaultPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Column(
//         children: [
//           Text(
//             question.question,
//             style: TextStyle(color: kBlackColor),
//           ),
//           SizedBox(height: kDefaultPadding / 2),
//           ...List.generate(
//             question.options.length,
//             (index) => Option(
//               index: index,
//               text: question.options[index],
//               press: () => _controller.checkAns(question, index, context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
