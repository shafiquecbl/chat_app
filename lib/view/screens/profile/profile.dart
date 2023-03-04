import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/helper/image.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/images.dart';
import 'package:chat_app/utils/style.dart';
import 'package:chat_app/view/screens/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/divider.dart';
import 'change_password.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile Info'),
        actions: [
          RoundButton(
              height: 35,
              radius: 8,
              color: Colors.transparent,
              textColor: Theme.of(context).primaryColor,
              text: 'Edit',
              onPressed: () {
                launchScreen(const EditProfileScreen());
              }),
        ],
      ),
      body: GetBuilder<AuthController>(builder: (con) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 30),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: getPixels(context, 120),
                      width: getPixels(context, 120),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: Hero(
                        tag: 'profile',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: image != null
                              ? Image.file(image!)
                              : CachedNetworkImage(
                                  imageUrl:
                                      con.appUser!.image ?? Images.demouser),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          pickImageDialog(context, (file) async {
                            await AuthController.to.uploadImage(file);
                            setState(() {
                              image = file;
                            });
                          });
                        },
                        child: Container(
                          height: getPixels(context, 30),
                          width: getPixels(context, 30),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.75,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Column(
                    children: [
                      Text(
                        con.appUser!.name!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              FFIcons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Text(con.appUser!.rating.toString(),
                                style: const TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on_rounded,
                              color: Colors.red, size: 15),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              '${con.appUser!.city}, ${con.appUser!.country}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: fontWeightNormal),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _detailsWidget('Email', con.appUser!.email!),
                _detailsWidget('Date of birth', con.appUser!.dob!),
                _detailsWidget('Gender', con.appUser!.gender!),
                _detailsWidget('Personal Info',
                    con.appUser!.infoVisibility! ? 'Private' : 'Public',
                    onTap: () {
                  launchScreen(const EditProfileScreen());
                }, textColor: Theme.of(context).primaryColor),
                _detailsWidget('Country', con.appUser!.country!),
                _detailsWidget('City/State', con.appUser!.city!),
                _detailsWidget('Password', 'Change Password', onTap: () {
                  launchScreen(const ChanegPasswordScreen());
                }, textColor: Theme.of(context).primaryColor),
                const SizedBox(height: 30),
                RoundButton(
                    color: Theme.of(context).cardColor,
                    text: 'Delete Your Account',
                    iconData: FFIcons.delete,
                    textColor: Theme.of(context).colorScheme.error,
                    onPressed: () {}),
                const SizedBox(height: 15),
                RoundButton(
                    color: Theme.of(context).cardColor,
                    text: 'Logout',
                    iconData: FFIcons.logout,
                    textColor: Theme.of(context).colorScheme.error,
                    onPressed: () {
                      con.logoutUser();
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }

  _detailsWidget(String title, String value,
          {Function()? onTap, Color? textColor}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Text(value,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: textColor)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const CustomDivider(),
        ],
      );
}
