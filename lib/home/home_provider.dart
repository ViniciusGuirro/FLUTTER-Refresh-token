import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_study/models/user_model.dart';

class HomeProvider extends ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  set user(UserModel value) {
    if (value != _user) {
      _user = value;
      notifyListeners();
    }
  }

  int _seconds = 10;
  Timer? _timer;

  int get seconds => _seconds;

  void startTimer() {
    _timer?.cancel();
    _seconds = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }
}
