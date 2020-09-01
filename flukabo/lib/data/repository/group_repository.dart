import 'dart:convert';

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
}
