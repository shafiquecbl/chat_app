import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/view/screens/auth/signup.dart';
import 'package:chat_app/view/screens/dashboard/dashboard.dart';
import 'package:chat_app/view/screens/intro/intro.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? user = FirebaseAuth.instance.currentUser;

  double initialWidth = 240;
  double initialHeight = 240;
  double borderRadius = 200;

  @override
  void initState() {
    iniData();
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
        });
      });
    });
  }

  iniData() async {
    bool isUserExist = await checkUser();
    Future.delayed(const Duration(seconds: 2), () {
      launchScreen(getHomepPage(isUserExist), replace: true);
    });
  }

  Widget getHomepPage(bool value) {
    if (user != null && value) {
      if (user != null && !user!.emailVerified) {
        return const LoginScreen(verification: true, back: false);
      } else {
        return const Dashboard();
      }
    } else if (user != null && value == false) {
      return const SignupScreen(back: false);
    } else {
      return const Intro();
    }
  }

  Future<bool> checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return AuthController.to
          .isUserExist(FirebaseAuth.instance.currentUser!.email!);
    } else {
      return false;
    }
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
