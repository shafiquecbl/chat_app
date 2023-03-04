import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/data/model/response/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/buttons.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';

class ChanegPasswordScreen extends StatefulWidget {
  const ChanegPasswordScreen({super.key});

  @override
  State<ChanegPasswordScreen> createState() => _ChanegPasswordScreenState();
}

class _ChanegPasswordScreenState extends State<ChanegPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isoldPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void initState() {
    AppUser user = AuthController.to.appUser!;
    oldPassword.text = user.password!;
    super.initState();
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: 'Old Password ',
                  hintText: 'Enter Old Password',
                  obscureText: isoldPasswordVisible,
                  prefixIcon:
                      Icon(FFIcons.lock, color: Theme.of(context).hintColor),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isoldPasswordVisible = !isoldPasswordVisible;
                        });
                      },
                      icon: Icon(FFIcons.eye,
                          color: Theme.of(context).hintColor)),
                  controller: oldPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter old password';
                    }
                    return null;
                  },
                ),

                // email textfield
                CustomTextField(
                  labelText: 'New Password',
                  hintText: 'Enter New Password',
                  obscureText: isNewPasswordVisible,
                  prefixIcon:
                      Icon(FFIcons.lock, color: Theme.of(context).hintColor),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isNewPasswordVisible = !isNewPasswordVisible;
                        });
                      },
                      icon: Icon(FFIcons.eye,
                          color: Theme.of(context).hintColor)),
                  controller: newPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter new password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                // dob textfield
                CustomTextField(
                  labelText: 'Confirm Password',
                  hintText: 'Enter password again',
                  obscureText: isConfirmPasswordVisible,
                  prefixIcon:
                      Icon(FFIcons.lock, color: Theme.of(context).hintColor),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                      icon: Icon(FFIcons.eye,
                          color: Theme.of(context).hintColor)),
                  controller: confirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter confirm password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    } else if (value != newPassword.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),

                SizedBox(height: getPixels(context, 50)),
                // save button
                PrimaryButton(
                  text: 'Update Password',
                  onPressed: _updatePassword,
                  options: ButtonOptions(
                      color: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updatePassword() {
    if (_formKey.currentState!.validate()) {
      AuthController.to.updatePassword(newPassword.text);
    }
  }
}
