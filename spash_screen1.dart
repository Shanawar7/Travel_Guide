import 'package:flutter/material.dart';
import 'package:travel_guide/screens/welcome_screen.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({super.key});

  @override
  _SplashScreenOneState createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _splashData = [
    {
      "image": "assets/images/splash1.jpg",
      "text": "Discover New Destinations.",
    },
    {
      "image": "assets/images/splash_two.jpg",
      "text": "Plan Your Perfect Adventure.",
    },
    {
      "image": "assets/images/splash_three.jpg",
      "text": "Explore the Uncharted!",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _splashData.length,
            physics: const AlwaysScrollableScrollPhysics(), // Changed to avoid page rebuilding
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _splashData[index]["image"]!,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: index == _splashData.length - 1
                        ? const Alignment(0, 0) // Adjusted to lower the text more
                        : Alignment.center,
                    child: Text(
                      _splashData[index]["text"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: index == _splashData.length - 1 ? 36 : 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          if (_currentPage != _splashData.length - 1)
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: () {
                  _pageController.animateToPage(
                    _splashData.length - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          if (_currentPage != _splashData.length - 1)
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _splashData.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 8,
                    width: _currentPage == index ? 20 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          if (_currentPage == _splashData.length - 1)
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WelcomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,  // Smaller horizontal padding for a smaller width
                      vertical: 12,    // Vertical padding remains the same
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 14),  // Slightly smaller text size
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}