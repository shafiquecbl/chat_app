import 'dart:convert';
import 'dart:io';
import 'package:chat_app/data/api/api_client.dart';
import 'package:chat_app/data/model/response/user.dart';
import 'package:chat_app/utils/app_constants.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token = '';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  // user exist
  Future<Response?> isUserExist(String email) async {
    return await apiClient
        .postData(AppConstants.checkEmailURL, {'email': email});
  }

  // get user
  Future<AppUser?> getUser(String email) async {
    var response =
        await apiClient.postData(AppConstants.getUserURL, {'email': email});
    if (response != null) {
      return AppUser.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // if user not exist save user
  Future<void> saveUser(Map<String, dynamic> data) async {
    await apiClient.postData(AppConstants.singupUserURL, data);
  }

  // update user
  Future<Response?> updateUser(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.updateUserURL, data);
  }

  Future<Response?> updatePassword(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.updatePasswordURL, data);
  }

  // upload user image
  Future<Response?> uploadUserImage(String email, File file) async {
    return await apiClient.postMultipartData(AppConstants.updateUserImage,
        [MultipartBody('image', XFile(file.path))],
        body: {'email': email});
  }
}
