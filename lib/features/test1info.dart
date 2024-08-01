import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/quizzpage22.dart';

import 'package:wdipl_interview_app/screens/components/testovervi.dart';
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
  final List<Map<String, String>> tests = [
    {
      'title': 'Technology Test - Easy Level',
      'description':
          'This test includes 10 questions focusing on basic concepts and fundamentals. Ideal for beginners.'
    },
    {
      'title': 'Technology Test - Medium Level',
      'description':
          'This test includes 10 questions focusing on intermediate concepts, suitable for those with some experience.'
    },
    {
      'title': 'Technology Test - Hard Level',
      'description':
          'This test includes 10 questions focusing on advanced topics, designed for experts.'
    },
    {
      'title': 'Mathematics & Logical Reasoning',
      'description':
          'This test includes 10 questions covering mathematics and logical reasoning to assess your analytical skills.'
    },
    {
      'title': 'Aptitude Test',
      'description':
          'This test includes 10 questions to evaluate your aptitude and problem-solving abilities.'
    },
  ];

  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _allStepsRead = false;

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

  void _checkIfReadAllSteps() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text(
              'Have you read all the test details carefully before starting the test?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _allStepsRead = true;
                });
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF508C9B),
        title: Text('Test Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Upcoming Tests Overview',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF134B70),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Please review the details of the following tests:',
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ...tests.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> test = entry.value;
              return _buildTestCard(
                  index + 1, test['title']!, test['description']!);
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
                if (_allStepsRead) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                } else {
                  _checkIfReadAllSteps();
                }
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

  Widget _buildTestCard(int stepNumber, String title, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF508C9B),
                  child: Text(
                    stepNumber.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
