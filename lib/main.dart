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

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityTitle;
  late Animation<double> _opacitySubtitle;
  late Animation<double> _opacityButton;
  late Animation<Offset> _offsetTitle;
  late Animation<Offset> _offsetSubtitle;
  late Animation<Offset> _offsetButton;
  late Animation<double> _scaleTitle;
  late Animation<double> _rotationTitle;

  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(
          milliseconds: 2000), // Increased duration for smoother animation
      vsync: this,
    );

    // Title animations
    _opacityTitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _offsetTitle =
        Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _scaleTitle = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );

    _rotationTitle = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Subtitle animations
    _opacitySubtitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _offsetSubtitle =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    // Button animations
    _opacityButton = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Interval(0.7, 1.0, curve: Curves.easeOut)),
    );

    _offsetButton =
        Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onProceed() async {
    setState(() {
      _isAnimating = true;
    });

    await _controller.reverse();

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
          image: DecorationImage(
            image: AssetImage(
                'assets/images/nobg.png'), // Path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Transform.translate(
                      offset: _offsetTitle.value,
                      child: Transform.scale(
                        scale: _scaleTitle.value,
                        child: Transform.rotate(
                          angle: _rotationTitle.value,
                          child: Opacity(
                            opacity: _opacityTitle.value,
                            child: Text(
                              'WDIPL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 170,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFf0413f), // orange-red color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Transform.translate(
                      offset: _offsetSubtitle.value,
                      child: Opacity(
                        opacity: _opacitySubtitle.value,
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 62,
                            fontWeight: FontWeight.bold,
                            color: Color(0xfff0413f),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Transform.translate(
                      offset: _offsetSubtitle.value,
                      child: Opacity(
                        opacity: _opacitySubtitle.value,
                        child: Text(
                          'Smart Assessment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            color: Color(0xfff0413f),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Transform.translate(
                      offset: _offsetButton.value,
                      child: Opacity(
                        opacity: _opacityButton.value,
                        child: ElevatedButton(
                          onPressed: _isAnimating ? null : _onProceed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFFf0413f), // orange-red color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 20),
                          ),
                          child: Text(
                            'Proceed',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Spacer(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
