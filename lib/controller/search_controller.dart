// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:chat_app/data/model/response/user.dart';
import 'package:chat_app/data/repository/search_repo.dart';
import 'package:chat_app/utils/timeago.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class SearchController extends GetxController implements GetxService {
  final SearchRepo searchRepo;
  SearchController({required this.searchRepo});

  List<AppUser> _users = [];
  List<AppUser> _filteredUsers = [];
  bool _loading = true;
  int _page = 1;
  bool _hasMore = true;

  List<AppUser> get users => _users;
  List<AppUser> get filteredUsers => _filteredUsers;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    update();
  }

  getUsers({bool reload = false}) async {
    if (reload) {
      _page = 1;
      _hasMore = true;
      _users.clear();
    }
    if (_hasMore) {
      setLoading(true);
      var response = await searchRepo.getUsersWithSimilarInterests(
          AuthController.to.appUser!.email!, _page);
      if (response != null) {
        var result = jsonDecode(response.body);
        _hasMore = result['hasMore'];
        _users.addAll(
            (result['users'] as List).map((e) => AppUser.fromJson(e)).toList());
        _filteredUsers = _users;
        _page++;
      }
      setLoading(false);
    }
  }

  getUsersBySearchQuery(String query) async {
    if (query.isEmpty) {
      _filteredUsers = _users;
      update();
    } else {
      _page = 1;
      setLoading(true);
      var response = await searchRepo.getUsersBySearchQuery(query, _page);
      if (response != null) {
        var result = jsonDecode(response.body);
        _hasMore = result['hasMore'];
        _filteredUsers =
            (result['users'] as List).map((e) => AppUser.fromJson(e)).toList();
        _page++;
      }
      setLoading(false);
    }
  }

  filterUsersBySex(int value) {
    if (value == 1) {
      _filteredUsers = users;
    }
    if (value == 2) {
      _filteredUsers = users.where((user) => user.gender == 'Male').toList();
    }
    if (value == 3) {
      _filteredUsers = users.where((user) => user.gender == 'Female').toList();
    }
    if (value == 4) {
      _filteredUsers = users.where((user) => user.gender == 'Other').toList();
    }
    update();
  }

  filterUserByAgeRange(int value) {
    if (value == 1) {
      _filteredUsers = users;
    }
    if (value == 2) {
      _filteredUsers = users
          .where((user) => getAge(user.dob!) >= 18 && getAge(user.dob!) <= 25)
          .toList();
    }
    if (value == 3) {
      _filteredUsers = users
          .where((user) => getAge(user.dob!) >= 25 && getAge(user.dob!) <= 35)
          .toList();
    }
    if (value == 4) {
      _filteredUsers = users
          .where((user) => getAge(user.dob!) >= 35 && getAge(user.dob!) <= 45)
          .toList();
    }
    if (value == 5) {
      _filteredUsers = users
          .where((user) => getAge(user.dob!) >= 45 && getAge(user.dob!) <= 55)
          .toList();
    }
    if (value == 6) {
      _filteredUsers = users
          .where((user) => getAge(user.dob!) >= 55 && getAge(user.dob!) <= 65)
          .toList();
    }
    if (value == 7) {
      _filteredUsers = users.where((user) => getAge(user.dob!) >= 65).toList();
    }
    update();
  }

  static SearchController get to => Get.find();
}
