import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaitoon_db_remember/views/login.dart';

class UiProvider extends ChangeNotifier {
  bool _isChecked = false;
  bool get ischecked => _isChecked;
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  late SharedPreferences storage;
  toggleCheck() {
    _isChecked = !ischecked;
    notifyListeners();
  }

  setRememberMe() {
    _rememberMe = true;
    storage.setBool('rememberMe', _rememberMe);
    notifyListeners();
  }

  logout(BuildContext context) {
    _rememberMe = false;
    storage.setBool('rememberMe', _rememberMe);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ),
    );
    notifyListeners();
  }

  initStorage() async {
    storage = await SharedPreferences.getInstance();
    _rememberMe = storage.getBool('rememberMe') ?? false;
    notifyListeners();
  }
}
