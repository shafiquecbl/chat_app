import 'package:chat_app/common/buttons.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/view/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';
import 'package:flutter/scheduler.dart';

import 'widget/verify_email_dialog.dart';

class LoginScreen extends StatefulWidget {
  final bool back, verification;
  const LoginScreen({this.back = true, this.verification = false, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    if (widget.verification) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context, builder: (context) => const VerifyEmailDialog());
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: widget.back ? const CustomBackButton() : null,
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
                obscureText: obscureText,
                prefixIcon:
                    Icon(FFIcons.lock, color: Theme.of(context).hintColor),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon:
                        Icon(FFIcons.eye, color: Theme.of(context).hintColor)),
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
                    AuthController.to
                        .loginUser(context, email.text, password.text);
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
