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
    final String json = await KanboardAPI().getJson(
      command: userCommands[UserProcedures.getById],
      params: {'user_id': id.toString()},
    );
    final result = jsonDecode(json)['result'];
    if (result != null) {
      final Map<String, String> body = Map.from(result as Map<String, dynamic>);
      print('Successfully fetched user $id.');
      return User.fromJson(body);
    } else {
      throw const Failure('Failed to fetch user.');
    }
  }

  Future<User> getUserByName(String name) async {
    final String response = await KanboardAPI().getJson(
      command: userCommands[UserProcedures.getByName],
      params: {'username': name},
    );
    if (jsonDecode(response)['result'] != null) {
      print('Successfully fetched user $name.');
      final Map<String, String> body =
          Map.from(jsonDecode(response)['result'] as Map<String, dynamic>);
      return User.fromJson(body);
    } else {
      throw const Failure('Failed to fetch user.');
    }
  }

  Future<List<User>> getAllUsers() async {
    final List<User> users = [];
    final String json = await KanboardAPI().getJson(
      command: userCommands[UserProcedures.getAll],
      params: {},
    );
    final List result = jsonDecode(json)['result'] as List;
    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        users.add(User.fromJson(Map.from(result[i] as Map<String, dynamic>)));
      }
      print('Succesfully fetched ${users.length} users.');
      return users;
    } else {
      print('Failed to fetch users.');
      throw const Failure('Failed to fetch users.');
    }
  }

  Future<bool> updateUser({
    @required int id,
    String username = '',
    String name = '',
    String email = '',
    String role = '',
  }) async {
    User user;
    try {
      user = await getUserByID(id);
    } on Failure catch (f) {
      print(f.message);
      rethrow;
    }
    final String json = await KanboardAPI().getJson(
      command: userCommands[UserProcedures.update],
      params: {
        'id': id.toString(),
        'name': name.isEmpty ? user.name : name,
        'username': username.isEmpty ? user.username : username,
        'email': email.isEmpty ? user.email : email,
        'role': role.isEmpty ? user.role : role,
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != null) {
      print('Successfully updated user $id.');
      return result == 'true';
    } else {
      print('Failed to fetch user.');
      return false;
    }
  }

  Future<bool> removeUser(int id) async {
    final String json = await KanboardAPI().getJson(
      command: userCommands[UserProcedures.remove],
      params: {
        'user_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != null) {
      print('Successfully removed user $id.');
      return result == 'true';
    } else {
      print('Failed to remove user.');
      return false;
    }
  }

  Future<bool> disableUser(int id) async {
    final String json = await KanboardAPI().getJson(
      command: userCommands[UserProcedures.disable],
      params: {
        'user_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != null) {
      print('Successfully disabled user $id.');
      return result == 'true';
    } else {
      print('Failed to disable user.');
      return false;
    }
  }

  Future<bool> enableUser(int id) async {
    final String json = await KanboardAPI().getJson(
      command: userCommands[UserProcedures.enable],
      params: {
        'user_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != null) {
      print('Successfully enabled user $id.');
      return result == 'true';
    } else {
      print('Failed to enable user.');
      return false;
    }
  }

  Future<bool> isActiveUser(int id) async => (await getUserByID(id)).isActive;
}
