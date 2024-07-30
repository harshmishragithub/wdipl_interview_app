import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/main.dart';
import 'package:wdipl_interview_app/screens/quiz/quiz_screen.dart';

void main() {
  runApp(MaterialApp(
    home: ExamInfoPage(),
  ));
}

class ExamInfoPage extends StatefulWidget {
  @override
  _ExamInfoPageState createState() => _ExamInfoPageState();
}

class _ExamInfoPageState extends State<ExamInfoPage>
    with SingleTickerProviderStateMixin {
  final List<String> steps = [
    'Register for the exam through the official portal.',
    'Download the admit card from your email or the portal.',
    'Prepare your documents and materials needed for the exam.',
    'Arrive at the exam center at least 30 minutes before the start time.',
    'Follow the instructions given by the invigilators.',
    'Complete the exam within the given time frame.',
    'Collect your results online on the announced date.'
  ];

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(1, 0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF508C9B),
        title: Text('Exam Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'How to Take Your Exam',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF134B70),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Follow these steps carefully to ensure a smooth and successful exam experience:',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ...steps.asMap().entries.map((entry) {
              int index = entry.key;
              String step = entry.value;
              return _buildStepCard(index + 1, step);
            }).toList(),
            SizedBox(height: 80), // Add space for the FAB
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SlideTransition(
            position: _animation,
            child: Text(
              'Start Test',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 90,
            width: 90,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              child: Icon(Icons.arrow_forward, size: 50, color: Colors.white),
              shape: CircleBorder(),
              backgroundColor: Color(0xFF134B70),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _buildStepCard(int stepNumber, String step) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF508C9B),
              child: Text(
                stepNumber.toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          step,
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
