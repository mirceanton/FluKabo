import 'package:flukabo/data/models/group.dart';
import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/group_procedures.dart';
import 'package:flukabo/res/kanboard/api_procedures/members_procedures.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the group management feature provided to admin users.
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
  /// [createGroup] returns the id of the newly created group if the creation
  /// was successful. If the creation failed, it throws an instance of Failure
  ///
  /// [name] is required as all groups must have a name
  /// [externalId] is an optional parameter. If no value is provided, the
  /// default is '0'
  ///
  Future<int> createGroup({
    @required String name,
    int externalId = 0,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: groupCommands[GroupProcedures.create],
      params: {
        'name': name,
        'external_id': externalId.toString(),
      },
    );
    print('Successfully fetched group $statusCode');
    return statusCode;
  }

  ///
  /// [getGroup] returns a Group object if the given id was valid, ot throws an
  /// instance of failure otherwise
  ///
  Future<GroupModel> getGroup(int id) async {
    final GroupModel group = await KanboardAPI().getObject<GroupModel>(
      command: groupCommands[GroupProcedures.get],
      params: {'group_id': id.toString()},
    );
    return group;
  }

  ///
  /// [getAllGroups] returns a List of groups if the fetch was successfull, or
  /// throws an instance of  Failure if the api call failed for some reason
  ///
  Future<List<GroupModel>> getAllGroups() async {
    final List<GroupModel> groups =
        await KanboardAPI().getObjectList<GroupModel>(
      command: groupCommands[GroupProcedures.getAll],
      params: {},
    );
    return groups;
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
    final GroupModel group = await getGroup(id);
    final bool status = await KanboardAPI().getBool(
      command: groupCommands[GroupProcedures.update],
      params: {
        'group_id': id.toString(),
        'name': name.isEmpty ? group.name : name,
        'external_id': externalId == -1
            ? group.externalID.toString()
            : externalId.toString(),
      },
    );
    return status;
  }

  ///
  /// [removeGroup] returns true if the group was successfully removed, or
  /// false otherwise
  /// This function completely removes the group from the databse, but will not
  /// delete the members of the group.
  ///! Be careful, as this action cannot be undone
  ///
  Future<bool> removeGroup(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: groupCommands[GroupProcedures.remove],
      params: {
        'group_id': id.toString(),
      },
    );
    return status;
  }

  ///
  /// [getMembersForGroup] returns a list of Users if the given [groupId] is
  /// valid, or throws an instance of Failure otherwise
  /// The returnes list of users represents all the members of the requested
  /// group
  ///
  Future<List<UserModel>> getMembersForGroup(int groupId) async {
    final List<UserModel> users = await KanboardAPI().getObjectList<UserModel>(
      command: membersCommands[MembersProcedures.getMembers],
      params: {'group_id': groupId.toString()},
    );
    return users;
  }

  ///
  /// [addUserToGroup] returns true if the given user was successfully added to
  /// the given group, or false otherwise
  ///
  Future<bool> addUserToGroup({
    @required int userId,
    @required int groupId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: membersCommands[MembersProcedures.addToGroup],
      params: {
        'group_id': groupId.toString(),
        'user_id': userId.toString(),
      },
    );
    return status;
  }

  ///
  /// [removeUserFromGroup] returns true if the given user was successfully
  /// removed from the given group, or false otherwise
  ///
  Future<bool> removeUserFromGroup({
    @required int userId,
    @required int groupId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: membersCommands[MembersProcedures.removeFromGroup],
      params: {
        'group_id': groupId.toString(),
        'user_id': userId.toString(),
      },
    );
    return status;
  }

  ///
  /// [isUserInGroup] returns true if the user with the given [userId] is part
  /// of the group with the given [groupId]
  ///
  Future<bool> isUserInGroup({
    @required int userId,
    @required int groupId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: membersCommands[MembersProcedures.isInGroup],
      params: {
        'group_id': groupId.toString(),
        'user_id': userId.toString(),
      },
    );
    return status;
  }
}
