import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  late String text = '';
  final Widget nextScreen;
  SplashScreen({Key? key, required this.nextScreen}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      curve: Curves.bounceOut,
      duration: 4000,
      splashTransition: SplashTransition.rotationTransition,
      splashIconSize: 200,
      function: () async {
        Future.delayed(const Duration(seconds: 2));
      },
      splash: const CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage('assets/images/water-cup.png'),
      ),
      nextScreen: widget.nextScreen,
      pageTransitionType: PageTransitionType.bottomToTop,
      animationDuration: const Duration(milliseconds: 2500),
    );
  }
}

// animated splash object
