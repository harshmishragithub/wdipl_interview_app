import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wdipl_interview_app/testoverview/testov4.dart';
import 'contt4.dart';

class ThankYouPage3 extends StatefulWidget {
  @override
  _ThankYouPage3State createState() => _ThankYouPage3State();
}

class _ThankYouPage3State extends State<ThankYouPage3>
    with SingleTickerProviderStateMixin {
  final QuizController3 quizController = Get.find<QuizController3>();
  late AnimationController _controller;
  late Animation<double> _iconAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _iconAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.8, curve: Curves.easeIn),
      ),
    );

    _buttonScaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Thank You",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFe21f88), // Custom AppBar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFe21f88),
              Color(0xFF52eefd),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _iconAnimation,
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                SizedBox(height: 30),
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                    "Answer Submitted Successfully!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                AnimatedBuilder(
                  animation: _buttonScaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _buttonScaleAnimation.value,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offAll(() => UpcomingTestPage4());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "Start Test Part 4",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF2d84b6),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
