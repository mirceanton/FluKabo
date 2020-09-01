import 'dart:convert';

import 'package:flukabo/data/models/group.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/kanboard_api_commands.dart';
import 'package:flutter/material.dart';

class GroupRepository {
  static final GroupRepository _instance = GroupRepository._constructor();

  factory GroupRepository() => _instance;
  GroupRepository._constructor(); // empty constructor

  Future<bool> createGroup({
    @required String name,
  }) async {
    final String response = jsonDecode(await KanboardAPI().getJson(
      command: groupCommands[GroupProcedures.create],
      params: {'name': name},
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

  Future<Group> getGroup(int id) async {
    final String json = await KanboardAPI().getJson(
      command: groupCommands[GroupProcedures.get],
      params: {'group_id': id.toString()},
    );
    final result = jsonDecode(json)['result'];
    if (result != null) {
      final Map<String, String> body = Map.from(result as Map<String, dynamic>);
      print('Successfully fetched group $id.');
      return Group.fromJson(body);
    } else {
      throw const Failure('Failed to fetch group.');
    }
  }

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
}
