import 'package:flutter/material.dart';

class UtilsServices {
  void showToast(
      {required BuildContext context,
      required String message,
      required int duration}) {
    final scaffold = ScaffoldMessenger.of(context);
    final snackBar = SnackBar(
      content: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 40.0,
        child: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
      duration: Duration(seconds: duration),
    );

    scaffold.showSnackBar(snackBar);
  }
}
