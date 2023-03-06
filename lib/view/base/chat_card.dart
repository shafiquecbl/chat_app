import 'package:chat_app/common/active_circle.dart';
import 'package:chat_app/common/network_image.dart';
import 'package:chat_app/data/model/body/contact.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/utils/style.dart';
import 'package:chat_app/utils/timeago.dart';
import 'package:chat_app/view/screens/home/home.dart';
import 'package:chat_app/view/screens/inbox/chat.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final ContactModel contact;
  const ChatCard({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          launchScreen(const ChatPage());
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: CustomNetworkImage(url: demoImages.first),
                    ),
                  ),
                  if (contact.user!.isOnline ?? false)
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: ActiveCircle(
                        size: 14,
                      ),
                    )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.user!.name!,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        contact.lastMessage!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text(TimeAgo.timeAgoSinceDate(contact.createdAt!),
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
