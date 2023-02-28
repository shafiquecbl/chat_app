import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/view/screens/auth/signup.dart';
import 'package:chat_app/view/screens/dashboard/dashboard.dart';
import 'package:chat_app/view/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20).copyWith(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter your phone number for\nsign in.',
                style: TextStyle(fontWeight: fontWeightNormal),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: email,
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon:
                    Icon(FFIcons.email, color: Theme.of(context).hintColor),
              ),
              CustomTextField(
                controller: password,
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon:
                    Icon(FFIcons.lock, color: Theme.of(context).hintColor),
                suffixIcon:
                    Icon(FFIcons.eye, color: Theme.of(context).hintColor),
              ),
              Row(
                children: [
                  Checkbox(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      value: true,
                      onChanged: (value) {}),
                  const SizedBox(width: 5),
                  Text(
                    'Remember Me',
                    style: TextStyle(
                        fontWeight: fontWeightNormal,
                        color: Theme.of(context).hintColor,
                        fontSize: 12),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontWeight: fontWeightNormal, fontSize: 12),
                      ))
                ],
              ),
              const SizedBox(height: 40),
              CustomButton(
                  text: 'Sign In',
                  onPressed: () {
                    launchScreen(const Dashboard());
                  }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont\'t have an account?'),
                  TextButton(
                      onPressed: () {
                        launchScreen(const SignupScreen());
                      },
                      child: const Text('Sign Up'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
