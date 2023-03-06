// ignore_for_file: library_prefixes

import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/data/model/body/contact.dart';
import 'package:chat_app/data/model/body/message.dart';
import 'package:chat_app/data/repository/chat_repo.dart';
import 'package:chat_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController implements GetxService {
  final ChatRepo chatRepo;
  ChatController({required this.chatRepo});

  late IO.Socket socket;

  List<ContactModel> _contacts = [];
  List<ContactModel> get contacts => _contacts;

  initSocket() {
    _connect();
  }

  _connect() {
    socket = IO.io(AppConstants.domain, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    _onConnect();
    _onDisconnect();
    _onError();
  }

  _onConnect() {
    socket.onConnect((data) => {onlineUser(), getContact()});
  }

  _onDisconnect() {
    socket.onDisconnect((data) => offlineUser());
  }

  onlineUser() => socket.emit('online', AuthController.to.appUser!.email);

  offlineUser() => socket.emit('offline', AuthController.to.appUser!.email);

  _onError() {
    socket.onError((data) => print('Error'));
  }

  sendMessage(String message, String receiver) {
    socket.emit(
        'message',
        MessageModel(
          message: message,
          sender: AuthController.to.appUser!.id,
          receiver: receiver,
        ).toJson());
  }

  getContact() {
    socket.on('contacts', (data) {
      _contacts = [];
      data.forEach((element) {
        _contacts.add(ContactModel.fromJson(element));
      });
      update();
    });
  }

  sendContactRequest() {
    socket.emit('contacts', AuthController.to.appUser!.id);
  }

  static ChatController get to => Get.find();
}
