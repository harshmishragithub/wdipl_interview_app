// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wdipl_interview_app/controllers/cont.dart';

// import '../../constants.dart';

// class ScoreScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     QuestionController _qnController = Get.put(QuestionController());
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
//           Column(
//             children: [
//               Spacer(flex: 3),
//               Text(
//                 "Score",
//                 style: TextStyle(color: kSecondaryColor, fontSize: 36),
//               ),
//               Spacer(),
//               Obx(() => Text(
//                     "${_qnController.numOfCorrectAns * 10}/${_qnController.questions.length * 10}",
//                     style: TextStyle(
//                       color: kSecondaryColor,
//                       fontSize: 36,
//                     ),
//                   )),
//               Spacer(flex: 3),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
