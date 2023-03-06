import 'package:chat_app/data/api/api_client.dart';
import 'package:chat_app/utils/app_constants.dart';
import 'package:http/http.dart';

class SearchRepo {
  final ApiClient apiClient;

  SearchRepo({required this.apiClient});

  Future<Response?> getUsersWithSimilarInterests(String email, int page) async {
    return await apiClient
        .postData(AppConstants.getUsersURL, {'email': email, 'page': page});
  }

  Future<Response?> getUsersBySearchQuery(String query, int page) async {
    return await apiClient
        .postData(AppConstants.searchUsersURL, {'query': query, 'page': page});
  }
}
