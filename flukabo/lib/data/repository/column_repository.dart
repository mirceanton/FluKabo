import 'dart:convert';

import 'package:flukabo/data/models/column.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/column_procedures.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the column management
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
      print('Failed to create column');
      return false;
    } else {
      final int statusCode = response == 'false' ? 0 : int.parse(response);
      print('Column created succesfully. GID: $statusCode');
      return true;
    }
  }

  ///
  /// [getColumnById] returns a Column object if the given id was valid, ot throws
  /// an instance of failure otherwise
  ///
  Future<ColumnModel> getColumnById(int id) async {
    final String json = await KanboardAPI().getJson(
      command: columnCommands[ColumnProcedures.get],
      params: {'column_id': id.toString()},
    );
    final Map<String, dynamic> result =
        jsonDecode(json)['result'] as Map<String, dynamic>;
    if (result != null) {
      print('Successfully fetched column $id.');
      return ColumnModel.fromJson(result);
    } else {
      throw const Failure('Failed to fetch column.');
    }
  }

  ///
  /// [getColumnsForProject] returns a list of all of the columns from the
  /// projects [projectId] board
  /// if the id is invalid, an instance of Failure is thrown
  ///
  Future<List<ColumnModel>> getColumnsForProject(int projectId) async {
    final List<ColumnModel> columns = [];
    final String json = await KanboardAPI().getJson(
      command: columnCommands[ColumnProcedures.getAll],
      params: {'project_id': projectId.toString()},
    );
    final List result = jsonDecode(json)['result'] as List;
    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        columns.add(
          ColumnModel.fromJson(Map.from(result[i] as Map<String, dynamic>)),
        );
      }
      print('Succesfully fetched ${columns.length} columns.');
      return columns;
    } else {
      print('Failed to fetch columns.');
      throw const Failure('Failed to fetch columns.');
    }
  }

  ///
  /// [updateColumn] returns true if the column was updated successfully or
  /// false otherwise
  ///
  /// [id] is the only required field, as this is the identifier by which we
  /// get the column which we want to update
  /// [title] is also required as this is also the only required field in the
  /// create method
  /// All the other fields, [taskLimit] and [description] are completely
  /// optional and will be kept unchanged if no value is provided
  ///
  Future<bool> updateColumn({
    @required int id,
    @required String title,
    int taskLimit = -1,
    String description = '',
  }) async {
    ColumnModel column;
    try {
      column = await getColumnById(id);
    } on Failure catch (f) {
      print(f.message);
      rethrow;
    }
    final String json = await KanboardAPI().getJson(
      command: columnCommands[ColumnProcedures.update],
      params: {
        'column_id': id.toString(),
        'title': title,
        'task_limit': taskLimit == -1
            ? column.taskLimit.toString()
            : taskLimit.toString(),
        'description': description.isEmpty ? column.description : description,
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null' && result != 'false' && result.isNotEmpty) {
      print('Successfully updated column $id.');
      return true;
    } else {
      print('Failed to update column.');
      return false;
    }
  }

  ///
  /// [moveColumn] returns true if the [columnId] was successfully moved to the
  /// [newPosition] in [projectId] board view
  ///
  Future<bool> moveColumn({
    @required int projectId,
    @required int columnId,
    @required int newPosition,
  }) async {
    final String json = await KanboardAPI().getJson(
      command: columnCommands[ColumnProcedures.relocate],
      params: {
        'project_id': projectId.toString(),
        'column_id': columnId.toString(),
        'position': newPosition.toString(),
      },
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null' && result != 'false' && result.isNotEmpty) {
      print(
        "Successfully moved column $columnId from project $projectId to position $newPosition.",
      );
      return true;
    } else {
      print('Failed to update column.');
      return false;
    }
  }

  ///
  /// [removeColumn] returns true if the column was successfully removed, or
  /// false otherwise
  /// This function completely removes the column from the databse
  ///! The deletion will fail if the column has tasks in it
  ///! Be careful, as this action cannot be undone
  ///
  Future<bool> removeColumn(int id) async {
    final String json = await KanboardAPI().getJson(
      command: columnCommands[ColumnProcedures.remove],
      params: {'column_id': id.toString()},
    );
    final String result = jsonDecode(json)['result'].toString();
    if (result != 'null' && result != 'false' && result.isNotEmpty) {
      print('Successfully removed column $id.');
      return true;
    } else {
      print('Failed to remove column.');
      return false;
    }
  }
}
