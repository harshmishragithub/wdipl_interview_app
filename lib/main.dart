import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wdipl_interview_app/features/personal1_Info_Screen.dart';
import 'features/splash.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

/* Made by
 Harsh Mishra  */

class WelcomeScreen extends StatelessWidget {
  void _onProceed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Form1Page()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF544b47), // Background color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.05),
            Text(
              'WDIPL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenSize.width * 0.2, // Scalable font size
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c94c1), // Blue color
              ),
            ),
            Spacer(),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: screenSize.width * 0.1, // Scalable font size
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c94c1),
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text(
              'Smart Assessment',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenSize.width * 0.06, // Scalable font size
                color: Color(0xFF2c94c1),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            ElevatedButton(
              onPressed: () => _onProceed(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2c94c1), // Blue color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.2,
                  vertical: screenSize.height * 0.025,
                ),
              ),
              child: Text(
                'Proceed',
                style: TextStyle(
                  fontSize: screenSize.width * 0.06, // Scalable font size
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
