import 'package:chat_app/data/model/language.dart';
import 'package:chat_app/utils/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages() {
    return AppConstants.languages;
  }
}
