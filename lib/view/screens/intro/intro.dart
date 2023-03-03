import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/utils/images.dart';
import 'package:chat_app/utils/style.dart';
import 'package:chat_app/view/screens/auth/login.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20).copyWith(bottom: 40).copyWith(top: 40),
      child: Column(
        children: [
          Image.asset(Images.intro, width: MediaQuery.of(context).size.width),
          const Spacer(),
          Text(
            'Enjoy the new experience of chating with global friends.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: fontSizeExtraLarge(context)),
          ),
          const SizedBox(height: 10),
          const Text(
            'Connect with people around the world.',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: 'Get Started',
            onPressed: () {
              launchScreen(const LoginScreen());
            },
          ),
        ],
      ),
    )));
  }
}
