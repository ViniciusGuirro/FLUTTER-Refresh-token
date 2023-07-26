import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class LocalStorage {
  Future<UserModel> getUserStorage() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    final dataStorage = storage.getString('user');

    if (dataStorage != null) {
      UserModel user = UserModel.fromMap(jsonDecode(dataStorage)['user']);

      return user;
    } else {
      return UserModel();
    }
  }

  Future<String> getOldToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    final oldToken = storage.getString('oldToken');

    if (oldToken != null) {
      return oldToken;
    } else {
      return '';
    }
  }

  Future<dynamic> getUserToken() async {
    return await getUserStorage().then((value) => value.token);
  }

  void clearStorage() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    storage.clear();
  }

  void removeKey(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    storage.remove(key);
  }
}
