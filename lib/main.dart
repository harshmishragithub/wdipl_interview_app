import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wdipl_interview_app/features/personal1_Info_Screen.dart';

import 'features/splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: WelcomeScreen(),
    );
  }
}

/* Made by
 Harsh Mishra  */

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset('assets/logo.png', height: 100), // Your logo here
          SizedBox(height: 20),
          CircularProgressIndicator(),
        ],
      ),
    ),
  );
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3e474d),
      body: Container(
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
                color: Color(0xFFf0413f), // orange-yellow color
              ),
            ),
            Spacer(),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 62,
                fontWeight: FontWeight.bold,
                color: Color(0xfff0413f),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Smart Assessment ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: Color(0xfff0413f),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Form1Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFf0413f), // orange-yellow color
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
