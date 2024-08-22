import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/test1/quizzpage22.dart';

class UpcomingTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Test part 1',
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
                      ' Easy level test',
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
                    // Text(
                    //   'Date: 20th August 2024\nTime: 10:00 AM\nSubject: English, Numerical Abilities, Reasoning',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     color: Color(0xff508C9B),
                    //     fontFamily:
                    //         'Raleway', // Custom font (make sure it's added in pubspec.yaml)
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(height: 20),
                    Text(
                      'Easy level test as per experience',
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
                        _showConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xffEEEEEE),
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
                      child: Text('start'),
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Are you sure you want to start the test?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizzPage()),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
