import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataController {

  Future<UserModel> getDataUser() async {
    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      final userDataRaw = await sharedPreferences.getString("user");
      final userData = jsonDecode(userDataRaw!);

      return UserModel.fromJson(userData);
    } catch(e) {
      rethrow;
    }
  }
}