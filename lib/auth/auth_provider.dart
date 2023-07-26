import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    if (value != _loading) {
      _loading = value;
      notifyListeners();
    }
  }
}
