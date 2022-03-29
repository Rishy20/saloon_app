import 'package:flutter/material.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/services/user.dart';

class UsersProvider with ChangeNotifier {
  List<User> _allUsers = [];
  final UserService _userService = UserService();

  UsersProvider() {
    _getAllUsers();
  }

//  getter
  List<User> get allUsers => _allUsers;

//  methods
  void _getAllUsers() async {
    _allUsers = await _userService.getAllUsers();
    notifyListeners();
  }
}
