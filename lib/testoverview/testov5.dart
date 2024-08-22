import 'package:flutter/material.dart';

import '../test5/quizzpage6.dart';

class UpcomingTestPage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Test part 5',
            style: TextStyle(
              color: Color(0xFFf0413f),
              fontFamily:
                  'Raleway', // Custom font (make sure it's added in pubspec.yaml)
            ),
          ),
          backgroundColor: Color(0xff3e474d),
          elevation: 0,
        ),
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(),
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
                        color: Color(0xFFf0413f),
                        fontFamily:
                            'Raleway', // Custom font (make sure it's added in pubspec.yaml)
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Aptitude level test as per experience.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFf0413f),
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
                        backgroundColor: Color(0xFFf0413f),
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
                  MaterialPageRoute(builder: (context) => QuizzPage5()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
