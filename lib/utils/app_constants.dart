// ignore_for_file: constant_identifier_names

import 'package:chat_app/data/model/body/language.dart';
import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Chat App';

  // API's
  static const String domain = 'http://192.168.18.52:3000';
  static const String baseURL = '$domain/api/v1';
  static const String checkEmailURL = '$baseURL/users/check-email';
  static const String getUserURL = '$baseURL/users/get-user';
  static const String singupUserURL = '$baseURL/users/signup';
  static const String updateUserURL = '$baseURL/users/update-user';
  static const String updatePasswordURL = '$baseURL/users/update-password';
  static const String updateUserImage = '$baseURL/users/update-image';
  static const String getUsersURL = '$baseURL/users/get-users';
  static const String searchUsersURL = '$baseURL/users/search-users';

  // Shared Key
  static const String THEME = 'theme';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  // Language
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];

  static List<String> addressLabels = ['Home', 'Office', 'Other'];
}
