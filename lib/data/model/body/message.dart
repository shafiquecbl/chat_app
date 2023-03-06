class MessageModel {
  String? id;
  String? message;
  String? sender;
  String? receiver;
  DateTime? createdAt;
  String? image;

  MessageModel({
    this.id,
    this.message,
    this.sender,
    this.receiver,
    this.createdAt,
    this.image,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        message: json["message"],
        sender: json["sender"],
        receiver: json["receiver"],
        createdAt: json["created_at"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "sender": sender,
        "receiver": receiver,
        "created_at": createdAt,
        "image": image,
      };
}
