import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/login_screen.dart';

class UiProvider extends ChangeNotifier {
  bool _rememberUser = false;
  bool rememberUser() {
    return _rememberUser;
  }

  bool _rememberAdmin = false;
  bool rememberAdmin() {
    return _rememberAdmin;
  }

  late SharedPreferences pref;
  setRememberUser() {
    _rememberUser = true;
    pref.setBool('rememberUser', _rememberUser);
    notifyListeners();
  }

  setRememberAdmin() {
    _rememberAdmin = true;
    pref.setBool('rememberAdmin', _rememberAdmin);
    notifyListeners();
  }

  logOutAdmin(BuildContext context) {
    _rememberAdmin = false;
    pref.setBool('rememberAdmin', _rememberAdmin);
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

  logOutUser(BuildContext context) {
    _rememberUser = false;
    pref.setBool('rememberUser', _rememberUser);
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

  initPref() async {
    pref = await SharedPreferences.getInstance();
    _rememberAdmin = pref.getBool('rememberAdmin') ?? false;
    _rememberUser = pref.getBool('rememberUser') ?? false;
    notifyListeners();
  }
}
