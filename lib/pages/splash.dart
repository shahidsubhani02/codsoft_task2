import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:quote_day/pages/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          backgroundColor: Color.fromARGB(255, 139, 172, 159),
          splashTransition: SplashTransition.slideTransition,
          duration: 3000,
          splashIconSize: 500,
          splash: const Image(image: AssetImage('image/quote.png')),
          nextScreen: HomePage()),
    );
  }
}
