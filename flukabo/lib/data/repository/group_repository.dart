import 'dart:convert';

import 'package:flukabo/data/models/group.dart';
import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/kanboard_api_commands.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with the
/// group management feature provided to admin users.
///
/// It includes the following functionality:
///   - Group creation
///   - Group update
///   - Group removal
///   - Individual Group retrieval (based on id)
///   - Bulk Group retrieval
///   - Group member manipulation
///     - Add user to group
///     - Get all members associated with a group
///     - Remove user for group
///     - Get wether or not the user is part of a group
///
class GroupRepository {
  static final GroupRepository _instance = GroupRepository._constructor();

  factory GroupRepository() => _instance;
  GroupRepository._constructor(); // empty constructor

  ///
  /// [createGroup] returns true if the group was succesfully created or false
  /// otherwise.
  /// [name] is required as all groups must have a name
  /// [externalId] is an optional parameter. If no value is provided, the
  /// default is '0'
  /// the [id] of the newly created group is the [statusCode] (as long as it is
  /// not 0. then if means there was an error)
  ///
  Future<bool> createGroup({
    @required String name,
    int externalId = 0,
  }) async {
    final String response = jsonDecode(await KanboardAPI().getJson(
      command: groupCommands[GroupProcedures.create],
      params: {
        'name': name,
        'external_id': externalId.toString(),
      },
    ))['result']
        .toString();
    final int statusCode = response == 'false' ? 0 : int.parse(response);
    if (statusCode == 0) {
      print('Failed to create group');
      return false;
    } else {
      print('Group created succesfully. GID: $statusCode');
      return true;
    }
  }

  ///
  /// [getGroup] returns a Group object if the given id was valid, ot throws an
  /// instance of failure otherwise
  ///
  Future<Group> getGroup(int id) async {
    final String json = await KanboardAPI().getJson(
      command: groupCommands[GroupProcedures.get],
      params: {'group_id': id.toString()},
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null') {
      final Map<String, String> body = Map.from(result as Map<String, dynamic>);
      print('Successfully fetched group $id.');
      return Group.fromJson(body);
    } else {
      throw const Failure('Failed to fetch group.');
    }
  }

  ///
  /// [getAllGroups] returns a List of groups if the fetch was successfull, or
  /// throws an instance of  Failure if the api call failed for some reason
  ///
  Future<List<Group>> getAllGroups() async {
    final List<Group> groups = [];
    final String json = await KanboardAPI().getJson(
      command: groupCommands[GroupProcedures.getAll],
      params: {},
    );
    final List result = jsonDecode(json)['result'] as List;
    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        groups.add(Group.fromJson(Map.from(result[i] as Map<String, dynamic>)));
      }
      print('Succesfully fetched ${groups.length} groups.');
      return groups;
    } else {
      print('Failed to fetch groups.');
      throw const Failure('Failed to fetch groups.');
    }
  }

  ///
  /// [updateGroup] returns true if the group was updated successfully ot false
  /// otherwise
  ///
  /// [id] is the only required field, as this is the identifier by which we
  /// get the group which we want to update
  /// All the other fields, [name] and [externalId] are completely optional and
  /// will be kept unchanged if no value is provided
  ///
  Future<bool> updateGroup({
    @required int id,
    String name = '',
    int externalId = -1,
  }) async {
    Group group;
    try {
      group = await getGroup(id);
    } on Failure catch (f) {
      print(f.message);
      rethrow;
    }
    final String json = await KanboardAPI().getJson(
      command: groupCommands[GroupProcedures.update],
      params: {
        'group_id': id.toString(),
        'name': name.isEmpty ? group.name : name,
        'external_id': externalId == -1
            ? group.externalID.toString()
            : externalId.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null') {
      print('Successfully updated group $id.');
      return result == 'true';
    } else {
      print('Failed to update group.');
      return false;
    }
  }

  ///
  /// [removeGroup] returns true if the group was successfully removed, or false
  /// otherwise
  /// This function completely removes the group from the databse, but will not
  /// delete the members of the group.
  ///! Be careful, as this action cannot be undone
  ///
  Future<bool> removeGroup(int id) async {
    final String json = await KanboardAPI().getJson(
      command: groupCommands[GroupProcedures.remove],
      params: {
        'group_id': id.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null') {
      print('Successfully removed group $id.');
      return result == 'true';
    } else {
      print('Failed to remove group.');
      return false;
    }
  }

  ///
  /// [getMembersForGroup] returns a list of Users if the given [groupId] is
  /// valid, or throws an instance of Failure otherwise
  /// The returnes list of users represents all the members of the requested
  /// group
  ///
  Future<List<User>> getMembersForGroup(int groupId) async {
    final List<User> users = [];
    final String json = await KanboardAPI().getJson(
      command: membersCommands[MembersProcedures.getMembers],
      params: {'group_id': groupId.toString()},
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
  /// [addUserToGroup] returns true if the given user was successfully added to
  /// the given group, or false otherwise
  ///
  Future<bool> addUserToGroup({
    @required int userId,
    @required int groupId,
  }) async {
    final String json = await KanboardAPI().getJson(
      command: membersCommands[MembersProcedures.addToGroup],
      params: {
        'group_id': groupId.toString(),
        'user_id': userId.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null' && result != 'false') {
      print('Successfully added user $userId to group $groupId.');
      return result == 'true';
    } else {
      print('Failed to add user to group.');
      return false;
    }
  }

  ///
  /// [removeUserFromGroup] returns true if the given user was successfully
  /// removed from the given group, or false otherwise
  ///
  Future<bool> removeUserFromGroup({
    @required int userId,
    @required int groupId,
  }) async {
    final String json = await KanboardAPI().getJson(
      command: membersCommands[MembersProcedures.removeFromGroup],
      params: {
        'group_id': groupId.toString(),
        'user_id': userId.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null' && result != 'false') {
      print('Successfully removed user $userId from group $groupId.');
      return result == 'true';
    } else {
      print('Failed to remove user from group.');
      return false;
    }
  }

  ///
  /// [isUserInGroup] returns true if the user with the given [userId] is part
  /// of the group with the given [groupId]
  ///
  Future<bool> isUserInGroup({
    @required int userId,
    @required int groupId,
  }) async {
    final String json = await KanboardAPI().getJson(
      command: membersCommands[MembersProcedures.isInGroup],
      params: {
        'group_id': groupId.toString(),
        'user_id': userId.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null') {
      print('Successfully fetched user $userId status in group $groupId.');
      return result == 'true';
    } else {
      print('Failed to getch users group status.');
      return false;
    }
  }
}
