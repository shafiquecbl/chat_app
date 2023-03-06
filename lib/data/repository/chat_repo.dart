import 'package:chat_app/data/api/api_client.dart';
import 'package:chat_app/utils/app_constants.dart';
import 'package:http/http.dart';

class ChatRepo {
  final ApiClient apiClient;
  ChatRepo({required this.apiClient});
}
