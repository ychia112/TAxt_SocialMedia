import 'package:ios_proj01/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ios_proj01/utils/user_preferences.dart';
import 'dart:convert';

class UserPreferences{
  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  static const myUser = User(
    imagePath: 'https://shayarimaza.com/files/boys-dp-images/sad-boy-dp-images/Sad-boy-Profile-Pic.jpg',
    name: 'Bruno Minor',
    address:'TheLongLongAddress'
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async{
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser(){
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}