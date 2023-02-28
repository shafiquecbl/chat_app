import 'package:flutter/material.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/utils/images.dart';
import 'package:chat_app/view/screens/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double initialWidth = 240;
  double initialHeight = 240;
  double borderRadius = 200;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      changeSize();
    });
    super.initState();
  }

  changeSize() {
    // change the size of the container with animation
    setState(() {
      initialWidth = 220;
      initialHeight = 220;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          borderRadius = 0;
          initialWidth = MediaQuery.of(context).size.width;
          initialHeight = MediaQuery.of(context).size.height;
          Future.delayed(const Duration(milliseconds: 325), () {
            launchScreen(const LoginScreen(),
                duration: const Duration(milliseconds: 500));
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedContainer(
        width: initialWidth,
        height: initialHeight,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: const Center(
            child: CircleAvatar(
          radius: 75,
          backgroundImage: AssetImage(Images.logo),
        )),
      )),
    );
  }
}
