import 'package:flutter/material.dart';

import 'package:wdipl_interview_app/test5/quizzpage6.dart';

class UpcomingTestPage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test part 5',
          style: TextStyle(
            fontFamily:
                'Raleway', // Custom font (make sure it's added in pubspec.yaml)
          ),
        ),
        backgroundColor: Color(0xFF134B70),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background.jpg'), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with transparency
          Container(
            color: Color(0xffEEEEEE),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Aptitude Test',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff508C9B),
                      fontFamily:
                          'Raleway', // Custom font (make sure it's added in pubspec.yaml)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Date: 20th August 2024\nTime: 10:00 AM\nSubject: English, Numerical Abilities, Reasoning',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff508C9B),
                      fontFamily:
                          'Raleway', // Custom font (make sure it's added in pubspec.yaml)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Prepare well and give your best! Remember to revise key topics and manage your time effectively during the test.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff508C9B),
                      fontFamily:
                          'Raleway', // Custom font (make sure it's added in pubspec.yaml)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizPage5()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xffEEEEEE),
                      backgroundColor: Color(0xFF134B70),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ), // Text color
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontFamily:
                            'Raleway', // Custom font (make sure it's added in pubspec.yaml)
                      ),
                    ),
                    child: Text('start'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
