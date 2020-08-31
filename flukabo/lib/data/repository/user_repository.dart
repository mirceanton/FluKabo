import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/kanboard_api_commands.dart';
import 'package:flutter/material.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._constructor();

  factory UserRepository() => _instance;
  UserRepository._constructor(); // empty constructor

  Future<void> createUser({
    @required String username,
    @required String password,
    String name = '',
    String email = '',
    String role = 'app-user',
  }) async {
    final String response = await KanboardAPI().getString(
      command: userCommands[UserProcedures.create],
      params: {
        'username': username,
        'password': password,
        'name': name,
        'email': email,
        'role': role,
      },
    );
    final int statusCode = response == 'false' ? 0 : int.parse(response);
    if (statusCode == 0) {
      print('Failed to add user');
      return false;
    } else {
      print('User added succesfully. UID: $statusCode');
      return true;
    }
  }
}
