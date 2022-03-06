// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:coalexpert/Models/User.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future getUser(uid) async {
    return http.get(Uri.parse(
        "https://coal-expert-back.herokuapp.com/get-user-info?uid=" + uid));
  }

  static Future setUser(UserM user) async {
    return http
        .post(Uri.parse("https://coal-expert-back.herokuapp.com/save-user-info"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({"userDet": user.toJson()}))
        .then((value) => {
              print(value.body),
            });
  }
}
