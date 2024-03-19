import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staj_case/pages/login/login_page.dart';

class UiProvider extends ChangeNotifier {
  bool _isChecked = false;
  bool get isChecked => _isChecked;
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  late SharedPreferences storage;
  String _currentUsername = '';
  String get currentUsername => _currentUsername;
  //Method to check and uncheck remember me
  // we need to do it using Provider state management

  toggleCheck() {
    _isChecked = !isChecked;
    notifyListeners();
  }

  //When login is successful, then we will true the value to remember our login session
  setRememberMe() {
    _rememberMe = true;
    //We store the value in secure storage to be remembered
    storage.setBool("rememberMe", _rememberMe);
    notifyListeners();
  }

  //Set rememberMe value to false
  logout(context) {
    _rememberMe = false;
    storage.setBool("rememberMe", _rememberMe);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    notifyListeners();
  }

  //Init Secure Storage
  initStorage() async {
    storage = await SharedPreferences.getInstance();
    _currentUsername = storage.getString("currentUsername") ?? '';
    _rememberMe = storage.getBool("rememberMe") ?? false;
    notifyListeners();
  }

  // Login is not showing now, because we checked the remember
  // now we must logout
  setCurrentUsername(String username) {
    _currentUsername = username;
    storage.setString("currentUsername", _currentUsername);
    notifyListeners();
  }
}
