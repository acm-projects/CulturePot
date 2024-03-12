import 'package:culture_pot/models/user.dart';
import 'package:culture_pot/services/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    try {
      User user = await _authMethods.getUserDetails();
      _user = user;
      notifyListeners();
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }
}
