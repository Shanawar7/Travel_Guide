import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreenThree extends StatelessWidget {
  const SplashScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash_three.jpg', // Replace with your image path
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          const Center(
            child: Text(
              'Start Your Adventure',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}