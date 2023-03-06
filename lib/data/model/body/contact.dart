import 'package:chat_app/data/model/response/user.dart';

class ContactModel {
  AppUser? user;
  String? lastMessage;
  bool? safe;
  DateTime? createdAt;

  ContactModel({
    this.user,
    this.lastMessage,
    this.safe,
    this.createdAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        user: AppUser.fromJson(json["user"]),
        lastMessage: json["lastMessage"],
        safe: json["safe"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "lastMessage": lastMessage,
        "safe": safe,
      };
}
