import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/kanboard_api_commands.dart';
import 'package:flutter/material.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._constructor();

  factory UserRepository() => _instance;
  UserRepository._constructor(); // empty constructor

}
