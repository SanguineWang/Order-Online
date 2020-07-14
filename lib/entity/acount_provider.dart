import 'package:flutter/material.dart';

class MyAcount with ChangeNotifier {
  // 账号
  String _number="";
  // 用户名
  String _name="";
  // 头像
  String _avatar="";

  get number => _number;
  get name => _name;
  get avatar => _avatar;

  set number(String number) {
    this._number = number;
    notifyListeners();
  }
  set name(String name) {
    this._name = name;
    notifyListeners();
  }
   set avatar(String avatar) {
    this._avatar = avatar;
    notifyListeners();
  }
  @override
  void dispose() {
    super.dispose();
  }
}
