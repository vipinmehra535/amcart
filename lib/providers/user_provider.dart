import 'package:amcart/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  /// The current user.
  ///
  /// This is a getter that returns the [_user] object. This is a private
  /// variable that is only accessible through this getter.
  ///
  /// This getter is used by the various widgets in the app to access the
  /// current user.
  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
