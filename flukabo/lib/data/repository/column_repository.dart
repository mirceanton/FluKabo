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
  /// [createColumn] returns the id of the newly created column if the creation
  /// was successful. If the creation failed, it thows an instance of Failure
  ///
  /// [projectId] is required in order to link this column to a project board
  /// [title] is required as all columns have to have a title up top
  /// [taskLimit] is optional, and the default value of 0 implies that no limit
  /// is actually set
  /// [description] is optional and the default value is an empty string: ''
  ///
  Future<int> createColumn({
    @required int projectId,
    @required String title,
    int taskLimit = 0,
    String description = '',
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: columnCommands[ColumnProcedures.create],
      params: {
        'project_id': projectId.toString(),
        'title': title,
        'task_limit': taskLimit.toString(),
        'description': description,
      },
    );
    print('Successfully fetched column $statusCode');
    return statusCode;
  }

  ///
  /// [getColumnById] returns a Column object if the given id was valid. If it
  /// was not, an instance of failure is thrown
  ///
  Future<ColumnModel> getColumnById(int id) async {
    final ColumnModel column = await KanboardAPI().getObject<ColumnModel>(
      command: columnCommands[ColumnProcedures.get],
      params: {'column_id': id.toString()},
    );
    return column;
  }

  ///
  /// [getColumnsForProject] returns a list of all of the columns from the
  /// projects [projectId] board
  /// if the id is invalid, an instance of Failure is thrown
  ///
  Future<List<ColumnModel>> getColumnsForProject(int projectId) async {
    final List<ColumnModel> columns =
        await KanboardAPI().getObjectList<ColumnModel>(
      command: columnCommands[ColumnProcedures.getAll],
      params: {'project_id': projectId.toString()},
    );
    return columns;
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
    final ColumnModel column = await getColumnById(id);
    final bool status = await KanboardAPI().getBool(
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
    return status;
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
    final bool status = await KanboardAPI().getBool(
      command: columnCommands[ColumnProcedures.relocate],
      params: {
        'project_id': projectId.toString(),
        'column_id': columnId.toString(),
        'position': newPosition.toString(),
      },
    );
    return status;
  }

  ///
  /// [removeColumn] returns true if the column was successfully removed, or
  /// false otherwise
  /// This function completely removes the column from the databse
  ///! The deletion will fail if the column has tasks in it
  ///! Be careful, as this action cannot be undone
  ///
  Future<bool> removeColumn(int id) async {
    final bool status = await KanboardAPI().getBool(
      command: columnCommands[ColumnProcedures.remove],
      params: {'column_id': id.toString()},
    );
    return status;
  }
}
