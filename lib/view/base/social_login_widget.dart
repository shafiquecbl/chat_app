import 'package:flutter/material.dart';
import 'package:chat_app/common/buttons.dart';
import 'package:chat_app/utils/images.dart';
import 'package:get/get.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        // or
        Center(
            child: Text(
          'or_continue_with'.tr,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.normal),
        )),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialLoginButton(
              image: Images.google,
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            SocialLoginButton(
              image: Images.facebook,
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            SocialLoginButton(
              image: Images.apple,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
