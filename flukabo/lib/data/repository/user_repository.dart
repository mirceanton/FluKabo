import 'dart:convert';

import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/kanboard_api_commands.dart';
import 'package:flutter/material.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._constructor();

  factory UserRepository() => _instance;
  UserRepository._constructor(); // empty constructor

  Future<bool> createUser({
    @required String username,
    @required String password,
    String name = '',
    String email = '',
    String role = 'app-user',
  }) async {
    final String response = jsonDecode(await KanboardAPI().getJson(
      command: userCommands[UserProcedures.create],
      params: {
        'username': username,
        'password': password,
        'name': name,
        'email': email,
        'role': role,
      },
    ))['result']
        .toString();
    final int statusCode = response == 'false' ? 0 : int.parse(response);
    if (statusCode == 0) {
      print('Failed to add user');
      return false;
    } else {
      print('User added succesfully. UID: $statusCode');
      return true;
    }
  }

  Future<User> getUserByID(int id) async {
    final String response = await KanboardAPI().getJson(
      command: userCommands[UserProcedures.create],
      params: {'user_id': id.toString()},
    );
    if (jsonDecode(response)['result'] != null) {
      final Map<String, String> body =
          Map.from(jsonDecode(response)['result'] as Map<String, dynamic>);
      return User.fromJson(body);
    } else {
      final String error = jsonDecode(response)['error'].toString();
      if (error == null) {
        throw const Failure('Failed to fetch user. Invalid id');
      } else {
        if (error.contains('Invalid params')) {
          throw const Failure('Failed to fetch user. Invalid parameters.');
        } else {
          throw const Failure('Failed to fetch user.');
        }
      }
    }
  }
}
