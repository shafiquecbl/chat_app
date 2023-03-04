import 'package:chat_app/common/buttons.dart';
import 'package:chat_app/common/snackbar.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/data/model/response/user.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/view/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';
import 'package:flutter/scheduler.dart';

class SignupScreen extends StatefulWidget {
  final bool back;
  const SignupScreen({this.back = false, super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  String gender = 'Male';
  bool obscureText = true;

  List<String> choices = [
    'Choice 1',
    'Choice 2',
    'Choice 3',
    'Choice 4',
    'Choice 5',
    'Choice 6',
    'Choice 7',
    'Choice 8',
    'Choice 9',
    'Choice 10',
  ];
  List<bool> selectedChoices = [];

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedChoices = List.generate(choices.length, (index) => false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.back ? const CustomBackButton() : null,
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20).copyWith(top: 40),
          child: Form(
            key: _formKey,
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
                  controller: name,
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon:
                      Icon(FFIcons.user, color: Theme.of(context).hintColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: email,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon:
                      Icon(FFIcons.email, color: Theme.of(context).hintColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
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
                      icon: Icon(FFIcons.eye,
                          color: Theme.of(context).hintColor)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                CustomDropDown(
                  labelText: 'Gender',
                  hintText: gender,
                  items: ['Male', 'Female', 'Other']
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                CustomTextField(
                  controller: dob,
                  labelText: 'Date of Birth',
                  hintText: 'Enter your date of birth',
                  readOnly: true,
                  prefixIcon: Icon(FFIcons.calendar,
                      color: Theme.of(context).hintColor),
                  suffixIcon: Icon(FFIcons.downArrow,
                      color: Theme.of(context).hintColor),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          dob.text = value.toString().split(' ').first;
                        });
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: country,
                  labelText: 'Country',
                  hintText: 'Enter your country',
                  prefixIcon: Icon(Icons.location_on_rounded,
                      color: Theme.of(context).hintColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: city,
                  labelText: 'City/State',
                  hintText: 'Enter your city/state',
                  prefixIcon: Icon(Icons.location_on_rounded,
                      color: Theme.of(context).hintColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city/state';
                    }
                    return null;
                  },
                ),
                // interests selection chips
                const SizedBox(height: 20),
                const Text(
                  'Interests',
                  style: TextStyle(fontWeight: fontWeightBold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Wrap(spacing: 10, runSpacing: 10, children: [
                  for (int i = 0; i < selectedChoices.length; i++)
                    ChoiceChip(
                      label: Text(choices[i],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black)),
                      selected: selectedChoices[i],
                      selectedColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      onSelected: (value) {
                        setState(() {
                          selectedChoices[i] = value;
                        });
                      },
                    ),
                ]),
                const SizedBox(height: 40),
                CustomButton(text: 'Sign Up', onPressed: _signup),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          launchScreen(const LoginScreen(), replace: true);
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
      ),
    );
  }

  _signup() {
    if (_formKey.currentState!.validate()) {
      List<String> finalChoice = [];
      for (int i = 0; i < selectedChoices.length; i++) {
        if (selectedChoices[i] == true) {
          finalChoice.add(choices[i]);
        }
      }

      if (finalChoice.isEmpty) {
        getSnackBar('Please select at least one interest', success: false);
      } else {
        AppUser user = AppUser(
            name: name.text,
            email: email.text,
            password: password.text,
            dob: dob.text,
            gender: gender,
            country: country.text,
            city: city.text,
            interests: finalChoice);

        AuthController.to.signupUser(context, user);
      }
    }
  }
}
