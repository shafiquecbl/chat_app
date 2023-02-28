// ignore_for_file: constant_identifier_names

import 'package:chat_app/data/model/language.dart';
import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Hotel Le Paris';

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
