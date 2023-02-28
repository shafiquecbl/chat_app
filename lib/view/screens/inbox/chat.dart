import 'package:chat_app/common/network_image.dart';
import 'package:chat_app/data/model/message.dart';
import 'package:chat_app/utils/style.dart';
import 'package:chat_app/view/screens/home/home.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  bool _isComposing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Send a message',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  helperStyle:
                      const TextStyle(fontSize: 12, color: Colors.grey),
                  prefixIcon: Wrap(
                    runAlignment: WrapAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: _handleSubmitted,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded),
            onPressed:
                _isComposing ? () => _handleSubmitted(_controller.text) : null,
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _controller.clear();
      setState(() {
        _isComposing = false;
        messages.insert(
          0,
          Message(
            text: text,
            time: '12:00',
            isMe: true,
            isSeen: false,
          ),
        );
      });
    }
  }

  Widget _buildMessage(Message message) {
    final isMe = message.isMe;
    final bubbleColor =
        isMe ? Theme.of(context).primaryColor : Theme.of(context).cardColor;
    final bubbleAlign =
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleBorderRadius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          );

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0).copyWith(
          left: !isMe ? 0.0 : getPixels(context, 70),
          right: !isMe ? getPixels(context, 70) : 0.0,
        ),
        child: Column(
          crossAxisAlignment: bubbleAlign,
          children: [
            Container(
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: bubbleBorderRadius,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    message.time,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: bubbleAlign == CrossAxisAlignment.end
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (isMe)
                  message.isSeen
                      ? Icon(
                          Icons.done_all_rounded,
                          size: 16.0,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(
                          Icons.done_all_rounded,
                          size: 16.0,
                          color: Theme.of(context).hintColor,
                        )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0.0,
        leading: const BackButton(),
        title: Row(
          children: [
            SizedBox(
                width: 50.0,
                height: 50.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CustomNetworkImage(url: demoImages.first))),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Muhammad Shafique',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call, color: Colors.red),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call, color: Theme.of(context).primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                return _buildMessage(message);
              },
              itemCount: messages.length,
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }
}
