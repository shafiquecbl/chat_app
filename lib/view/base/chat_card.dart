import 'package:chat_app/common/active_circle.dart';
import 'package:chat_app/common/network_image.dart';
import 'package:chat_app/helper/navigation.dart';
import 'package:chat_app/utils/style.dart';
import 'package:chat_app/utils/timeago.dart';
import 'package:chat_app/view/screens/home/home.dart';
import 'package:chat_app/view/screens/inbox/chat.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final int index;
  const ChatCard({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const read = true;
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
                    children: const [
                      Text(
                        'Muhammad Shafique',
                      ),
                      SizedBox(height: 5),
                      Opacity(
                        opacity: read == true ? 0.64 : 1,
                        child: Text(
                          "This is a message from the user to the tasker ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: read == true
                                  ? FontWeight.normal
                                  : FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Opacity(
                    opacity: read == true ? 0.64 : 1,
                    child: Text(TimeAgo.timeAgoSinceDate(DateTime.now()),
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: read == true
                                ? FontWeight.normal
                                : FontWeight.bold)),
                  ),
                  const SizedBox(height: 5),
                  // message count
                  if (!read == false)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
