import 'dart:convert';

import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/column_procedures.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the group management feature provided to admin users.
///
/// It includes the following functionality:
///   - Create Column
///   - Update Column
///   - Remove Column
///   - Individual Column retrieval (based on id)
///   - Bulk Column retrieval
///   - Relocate Column (change position)
///
class ColumnRepository {
  static final ColumnRepository _instance = ColumnRepository._constructor();

  factory ColumnRepository() => _instance;
  ColumnRepository._constructor(); // empty constructor

  ///
  /// [createColumn] returns true if the column was succesfully created or false
  /// otherwise.
  ///
  /// [projectId] is required in order to link this column to a project board
  /// [title] is required as all columns have to have a title up top
  /// [taskLimit] is optional, and the default value of 0 implies that no limit
  /// is actually set
  /// [description] is optional and the default value is empty
  ///
  Future<bool> createColumn({
    @required int projectId,
    @required String title,
    int taskLimit = 0,
    String description = "",
  }) async {
    final String json = await KanboardAPI().getJson(
      command: columnCommands[ColumnProcedures.create],
      params: {
        'project_id': projectId.toString(),
        'title': title,
        'task_limit': taskLimit.toString(),
        'description': description,
      },
    );
    final String response = jsonDecode(json)['result'].toString();
    if (response == 'false' || response == 'null' || response.isEmpty) {
      print('Failed to create group');
      return false;
    } else {
      final int statusCode = response == 'false' ? 0 : int.parse(response);
      print('Group created succesfully. GID: $statusCode');
      return true;
    }
  }
}
