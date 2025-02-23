import 'dart:convert';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/request.dart';

class UsersService {

  static Future<User> getUserIcon() async {
    final response = await Request.getFrom('/userCard');

    final Map<String, dynamic> jsonMap = json.decode(response.body);
    return User.fromJson(jsonMap);
  }

  static Future<User> getOtherUserIcon(int userId) async {
    final response = await Request.getFrom('/userCard/$userId');

    final Map<String, dynamic> jsonMap = json.decode(response.body);
    return User.fromJson(jsonMap);
  }

}