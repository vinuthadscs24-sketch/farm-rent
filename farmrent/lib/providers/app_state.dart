import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isLender = false;
  bool get isLender => _isLender;

  void setRole(bool status) {
    _isLender = status;
    notifyListeners();
  }
}