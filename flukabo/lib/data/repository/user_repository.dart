import 'dart:convert';

import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/kanboard_api_commands.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with the
/// users management feature provided to admin users.
///
/// It includes the following functionality:
///   - User creation
///   - User update
///   - User removal
///   - User retrieval (based on either name or id)
///   - User enable/disable
///
class UserRepository {
  static final UserRepository _instance = UserRepository._constructor();

  factory UserRepository() => _instance;
  UserRepository._constructor(); // empty constructor

  ///
  /// [createUser] returns true if the user was added successfully ot false
  /// otherwise
  ///
  /// [username] and [password] are required, as all users have to have a way to
  /// log in
  /// [name] and [email] are optional, and can be changed later if needed
  /// If no value is provided, then these fields will be represented by an empty
  /// string
  /// [role] is also optional, but has a default value of 'app-user'.
  /// In order to provide higher privileges for the user, make sure to specify
  /// the correct role, such as 'app-manager' or 'app-admin'
  ///
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

  ///
  ///[getUserById] returns a User object if the given id is valid
  /// or throws a Failure otherwise
  ///
  Future<User> getUserById(int id) async {
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

  ///
  ///[getUserByName] returns a User object if the given name is valid
  /// or throws a Failure otherwise (also throws failure if name doesn't exist)
  ///
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

  ///
  /// [getAllUsers] returns a List of users if the fetch was successfull, or it
  /// throws a Failure if the api call failed for some reason
  ///
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

  ///
  /// [updateUser] returns true if the user was updated successfully ot false
  /// otherwise
  ///
  /// [id] is the only required field, as this is the identifier by which we
  /// get the user which we want to update
  /// All the other fields, aka [username], [name], [email] and [role] are
  /// completely optional and will be kept unchanged if no value is provided
  ///
  Future<bool> updateUser({
    @required int id,
    String username = '',
    String name = '',
    String email = '',
    String role = '',
  }) async {
    User user;
    try {
      user = await getUserById(id);
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

  ///
  /// [removeUser] returns true if the user was successfully removed, or false
  /// otherwise
  /// This function completely removes the user from the databse.
  ///! Be careful, as this action cannot be undone
  ///
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

  ///
  /// [disableUser] returns true if the user was successfully disabled, or false
  /// otherwise
  /// This function sets the user.isActive to false
  /// This can be undone via the [enableUser] function
  ///
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

  ///
  /// [enableUser] returns true if the user was successfully enabled, or false
  /// otherwise
  /// This function sets the user.isActive to true
  /// This can be undone via the [disableUser] function
  ///
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

  /// [isActiveUser] returns the user.isActive field
  Future<bool> isActiveUser(int id) async => (await getUserById(id)).isActive;
}
