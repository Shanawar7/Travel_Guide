import 'package:flutter/material.dart';
import 'spash_screen3.dart';

class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SplashScreenThree()),
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash_two.jpg', // Replace with your image path
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          const Center(
            child: Text(
              'Discover Cultures',
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