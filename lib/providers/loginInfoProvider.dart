import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/services/user.dart';

class LoginInfoProvider with ChangeNotifier {
  var _loginInfo;
  final _db = Localstore.instance;

  LoginInfoProvider() {
    _getLoginInfo();
  }

//  getter
  get loginInfo => _loginInfo;

//  methods
  void _getLoginInfo() async {
    _loginInfo = await _db.collection('login').doc('loginData').get();
    notifyListeners();
  }

  void setLoginInfo(Map<String, dynamic> loginInfo) async {
    _loginInfo = loginInfo;
    _db.collection('login').doc('loginData').set(loginInfo);
    notifyListeners();
  }
}
