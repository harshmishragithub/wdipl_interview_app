import 'package:flutter/material.dart';
import '../test4/quizzpage5.dart';

class UpcomingTestPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test part 4',
          style: TextStyle(
            color: Colors.white,
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
                    'Maths and Logic Test',
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
                    'Maths and Logic level test as per experience.',
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
                      _showReadyDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xffEEEEEE), // Text color
                      backgroundColor: Color(0xFF134B70),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontFamily:
                            'Raleway', // Custom font (make sure it's added in pubspec.yaml)
                      ),
                    ),
                    child: Text('Start'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReadyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ready to Start?'),
          content: Text('Are you ready to take the test?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage4()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
