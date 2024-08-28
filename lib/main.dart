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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF544b47), // Updated background color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              'WDIPL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 170,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c94c1), // blue color
              ),
            ),
            Spacer(),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 62,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c94c1),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Smart Assessment',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: Color(0xFF2c94c1),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _onProceed(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2c94c1), // blue color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              ),
              child: Text(
                'Proceed',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
