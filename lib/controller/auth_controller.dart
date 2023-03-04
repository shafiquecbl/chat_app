// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:chat_app/view/screens/auth/widget/verify_email_dialog.dart';
import 'package:chat_app/view/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/common/snackbar.dart';
import 'package:chat_app/data/model/response/user.dart';
import 'package:chat_app/data/repository/auth_repo.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/view/screens/auth/login.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  FirebaseAuth auth = FirebaseAuth.instance;
  AppUser? appUser;
  User? get user => FirebaseAuth.instance.currentUser;

  Future<bool> isUserExist(String email) async {
    var response = await authRepo.isUserExist(email);
    if (response != null) {
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        token = data['token'];
      }
      return data['status'];
    } else {
      return false;
    }
  }

  Future<void> getUser() async {
    appUser = await authRepo.getUser(user!.email!);
    update();
  }

  loginUser(BuildContext context, String email, String password) async {
    email = email.trim().toLowerCase();
    SmartDialog.showLoading();
    // is user exists
    bool exist = await isUserExist(email);
    if (exist) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        SmartDialog.dismiss();
        if (!value.user!.emailVerified) {
          showDialog(
              context: context,
              builder: (context) => const VerifyEmailDialog(fromSignUp: false));
        } else {
          getUser();
          launchScreen(const Dashboard(), replace: true);
        }
      }).catchError((e) {
        SmartDialog.dismiss();
        getSnackBar('${e.message}', success: false);
      });
    } else {
      SmartDialog.dismiss();
      getSnackBar('User not found', success: false);
    }
  }

  Future<void> signupUser(BuildContext context, AppUser newUser) async {
    SmartDialog.showLoading();
    newUser.email = newUser.email!.trim().toLowerCase();
    bool userExist = await isUserExist(newUser.email!);
    if (userExist) {
      SmartDialog.dismiss();
      getSnackBar('User already exists', success: false);
    } else {
      return auth
          .createUserWithEmailAndPassword(
              email: newUser.email!, password: newUser.password!)
          .then((value) async {
        await authRepo.saveUser(newUser.toJson());
        SmartDialog.dismiss();
        showDialog(
            context: context, builder: (context) => const VerifyEmailDialog());
      }).catchError((e) {
        SmartDialog.dismiss();
        getSnackBar('${e.message}', success: false);
      });
    }
  }

  updateUser(AppUser newUser) async {
    SmartDialog.showLoading();
    newUser.email = appUser!.email;
    var response = await authRepo.updateUser(newUser.toJson());
    SmartDialog.dismiss();
    if (response != null) {
      getSnackBar('Profile updated successfully');
      var data = jsonDecode(response.body);
      appUser = AppUser.fromJson(data);
      update();
    }
  }

  void updatePassword(String text) async {
    SmartDialog.showLoading();

    var response = await authRepo.updatePassword({
      'email': appUser!.email,
      'password': text,
    });
    if (response != null) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: appUser!.email!, password: appUser!.password!);
      FirebaseAuth.instance.currentUser!.updatePassword(text);
      appUser!.password = text;
      SmartDialog.dismiss();
      getSnackBar('Password updated successfully');
      update();
    }
  }

  Future<void> uploadImage(File file) async {
    SmartDialog.showLoading();
    var response = await authRepo.uploadUserImage(appUser!.email!, file);
    SmartDialog.dismiss();
    if (response != null) {
      var data = jsonDecode(response.body);
      appUser!.image = data['image'];
      getSnackBar('Image updated successfully');
      update();
    }
  }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    launchScreen(const LoginScreen(back: false), replace: true);
  }

  static AuthController get to => Get.find();
}
