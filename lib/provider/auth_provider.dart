import 'package:flutter/material.dart';
import 'package:mega_mall/model/user_model.dart';

import '../service/user_service.dart';


class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> register(UserModel user) async {
    _setLoading(true);
    final success = await _userService.register(user);
    _setLoading(false);
    return success;
  }

  Future<bool> login(UserModel user) async {
    _setLoading(true);
    final success = await _userService.login(user);
    _setLoading(false);
    return success;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}