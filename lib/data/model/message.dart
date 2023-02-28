class Message {
  final String text;
  final String time;
  final bool isMe;
  bool isSeen;

  Message({
    required this.text,
    required this.time,
    required this.isMe,
    this.isSeen = false,
  });
}

List<Message> messages = [
  Message(
    text: 'How are you?',
    time: '10:02 AM',
    isMe: true,
    isSeen: true,
  ),
  Message(
    text: 'Hello',
    time: '10:00 AM',
    isMe: false,
    isSeen: true,
  ),
  Message(
    text: 'Hi',
    time: '10:01 AM',
    isMe: true,
    isSeen: true,
  ),
];
