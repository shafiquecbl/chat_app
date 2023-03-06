import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/data/model/body/contact.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';
import 'package:chat_app/view/base/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    ChatController.to.sendContactRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: const [
              // explore
              Text(
                'Hello, Shafique',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: fontWeightBold,
                ),
              ),
              SizedBox(height: 10),
              Spacer(),
              Icon(FFIcons.notification)
            ],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: search,
            hintText: 'Search',
            padding: const EdgeInsets.symmetric(vertical: 15),
            prefixIcon:
                Icon(Icons.search_rounded, color: Theme.of(context).hintColor),
          ),
          GetBuilder<ChatController>(builder: (con) {
            return Expanded(
              child: ListView.builder(
                  itemCount: con.contacts.length,
                  itemBuilder: ((context, index) {
                    ContactModel contact = con.contacts[index];
                    return ChatCard(contact: contact);
                  })),
            );
          }),
        ],
      ),
    ));
  }
}
