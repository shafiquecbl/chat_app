import 'package:chat_app/common/buttons.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/view/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List<bool> choice = List.generate(10, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20).copyWith(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter your details below to\nsign up.',
                style: TextStyle(fontWeight: fontWeightNormal),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: email,
                labelText: 'Name',
                hintText: 'Enter your name',
                prefixIcon:
                    Icon(FFIcons.user, color: Theme.of(context).hintColor),
              ),
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
              CustomTextField(
                controller: password,
                labelText: 'Date of Birth',
                hintText: 'Enter your date of birth',
                prefixIcon:
                    Icon(FFIcons.calendar, color: Theme.of(context).hintColor),
                suffixIcon:
                    Icon(FFIcons.downArrow, color: Theme.of(context).hintColor),
              ),
              CustomTextField(
                controller: password,
                labelText: 'Country',
                hintText: 'Enter your country',
                prefixIcon: Icon(Icons.location_on_rounded,
                    color: Theme.of(context).hintColor),
              ),
              CustomTextField(
                controller: password,
                labelText: 'City/State',
                hintText: 'Enter your city/state',
                prefixIcon: Icon(Icons.location_on_rounded,
                    color: Theme.of(context).hintColor),
              ),
              // interests selection chips
              const SizedBox(height: 20),
              const Text(
                'Interests',
                style: TextStyle(fontWeight: fontWeightBold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(spacing: 10, runSpacing: 10, children: [
                for (int i = 0; i < choice.length; i++)
                  ChoiceChip(
                    label: Text('Choice ${i + 1}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black)),
                    selected: choice[i],
                    selectedColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                    onSelected: (value) {
                      setState(() {
                        choice[i] = value;
                      });
                    },
                  ),
              ]),
              const SizedBox(height: 40),
              CustomButton(text: 'Sign Up', onPressed: () {}),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {
                        launchScreen(const LoginScreen(), isNewTask: true);
                      },
                      child: const Text('Sign In'))
                ],
              ),
              // privacy policy and terms of use rich text
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By signing up, you agree to our ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: fontWeightNormal),
                  children: [
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: fontWeightBold),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: fontWeightBold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
