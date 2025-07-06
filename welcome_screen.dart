import 'package:flutter/material.dart';
import 'package:travel_guide/screens/signin_screen.dart';
import 'package:travel_guide/screens/signup_screen.dart';
import 'package:travel_guide/widgets/scaffold_widget.dart';
import 'package:travel_guide/widgets/welcome_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and buttons
        children: [
          // Welcome Text Section
          Flexible(
            flex: 2, // Reduced flex to move the text higher
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'LET  THE JOURNEY BEGIN \n',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "\n",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Buttons Section
          Flexible(
            flex: 3, // Increased flex for the buttons section to push them lower
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the bottom
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Keep buttons horizontally aligned
                    children: [
                      Expanded(
                        child: WelcomeButton(
                          buttonText: "Sign in",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SignInScreen()),
                            );
                          },
                          color: Colors.transparent,
                          textColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10), // Add spacing between buttons
                      Expanded(
                        child: WelcomeButton(
                          buttonText: "Sign up",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SignUpScreen()),
                            );
                          },
                          color: Colors.transparent,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
