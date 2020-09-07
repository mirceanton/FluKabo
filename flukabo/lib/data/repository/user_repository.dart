import 'package:flukabo/data/models/group.dart';
import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/members_procedures.dart';
import 'package:flukabo/res/kanboard/api_procedures/user_procedures.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the users management feature provided to admin users.
///
/// It includes the following functionality:
///   - User creation
///   - User update
///   - User removal
///   - Individual User retrieval (based on either name or id)
///   - Bulk Users retrieval
///   - User enable/disable
///   - Get all groups associated to the user
///
class UserRepository {
  static final UserRepository _instance = UserRepository._constructor();

  factory UserRepository() => _instance;
  UserRepository._constructor(); // empty constructor

  ///
  /// [createUser] returns the id of the newly created user if the creation
  /// was successfull. If the creation failed, an instance of Failure is thrown
  ///
  /// [username] and [password] are required, as all users have to have a way
  /// to log in
  /// [name] and [email] are optional, and can be changed later if needed
  /// If no value is provided, then these fields will be represented by an
  /// empty string
  /// [role] is also optional, but has a default value of 'app-user'.
  /// In order to provide higher privileges for the user, make sure to specify
  /// the correct role, such as 'app-manager' or 'app-admin'
  ///
  Future<int> createUser({
    @required String username,
    @required String password,
    String name = '',
    String email = '',
    String role = 'app-user',
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: userCommands[UserProcedures.create],
      params: {
        'username': username,
        'password': password,
        'name': name,
        'email': email,
        'role': role,
      },
    );
    return statusCode;
  }

  ///
  ///[getUserById] returns a User object if the given id is valid
  /// or throws a Failure otherwise
  ///
  Future<UserModel> getUserById(int id) async {
    final UserModel user = await KanboardAPI().getObject<UserModel>(
      command: userCommands[UserProcedures.getById],
      params: {'user_id': id.toString()},
    );
    return user;
  }

  ///
  ///[getUserByUsername] returns a User object if the given name is valid
  /// or throws a Failure otherwise (also throws failure if name doesn't exist)
  ///
  Future<UserModel> getUserByUsername(String name) async {
    final UserModel user = await KanboardAPI().getObject<UserModel>(
      command: userCommands[UserProcedures.getByName],
      params: {'username': name},
    );
    return user;
  }

  ///
  /// [getAllUsers] returns a List of users if the fetch was successfull, or it
  /// throws a Failure if the api call failed for some reason
  ///
  Future<List<UserModel>> getAllUsers() async {
    final List<UserModel> users = await KanboardAPI().getObjectList<UserModel>(
      command: userCommands[UserProcedures.getAll],
      params: {},
    );
    return users;
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
    final UserModel user = await getUserById(id);
    final bool status = await KanboardAPI().getBool(
      command: userCommands[UserProcedures.update],
      params: {
        'id': id.toString(),
        'name': name.isEmpty ? user.name : name,
        'username': username.isEmpty ? user.username : username,
        'email': email.isEmpty ? user.email : email,
        'role': role.isEmpty ? user.role : role,
      },
    );
    return status;
  }

  ///
  /// [removeUser] returns true if the user was successfully removed, or false
  /// otherwise
  /// This function completely removes the user from the databse.
  ///! Be careful, as this action cannot be undone
  ///
  Future<bool> removeUser(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: userCommands[UserProcedures.remove],
      params: {
        'user_id': id.toString(),
      },
    );
    return status;
  }

  ///
  /// [disableUser] returns true if the user was successfully disabled, or
  /// false otherwise
  /// This function sets the user.isActive to false
  /// This can be undone via the [enableUser] function
  ///
  Future<bool> disableUser(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: userCommands[UserProcedures.disable],
      params: {'user_id': id.toString()},
    );
    return status;
  }

  ///
  /// [enableUser] returns true if the user was successfully enabled, or false
  /// otherwise
  /// This function sets the user.isActive to true
  /// This can be undone via the [disableUser] function
  ///
  Future<bool> enableUser(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: userCommands[UserProcedures.enable],
      params: {'user_id': id.toString()},
    );
    return status;
  }

  /// [isActiveUser] returns the user.isActive field
  Future<bool> isActiveUser(int id) async => (await getUserById(id)).isActive;

  ///
  /// [getGroupsForUser] returns a list of all the groups for the giver
  /// [userId] user. (all the groups the user is a member in)
  ///
  Future<List<GroupModel>> getGroupsForUser(int userId) async {
    final List<GroupModel> groups =
        await KanboardAPI().getObjectList<GroupModel>(
      command: membersCommands[MembersProcedures.getGroups],
      params: {'user_id': userId.toString()},
    );
    return groups;
  }
}
