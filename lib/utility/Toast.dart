import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class toast {
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }
}