import 'package:flutter/material.dart';
import '../../data/models/task_link.dart';
import '../../data/singletons/kanboard_api_client.dart';
import '../../res/kanboard/api_procedures/task_link_procedures.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// task link management
///
/// It includes the following functionality:
///   - Create new Link
///   - Retrieve Link
///     - By Id
///   - Retrieve All Links
///   - Update Link
///   - Remove Link
///
class TaskLinkRepository {
  static final TaskLinkRepository _instance = TaskLinkRepository._constructor();

  factory TaskLinkRepository() => _instance;
  TaskLinkRepository._constructor(); // empty constructor

  Future<int> createLint({
    @required int taskId,
    @required int oppositeTaskId,
    @required int linkId,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: taskLinkCommands[TaskLinkProcedures.create],
      params: {
        'task_id': taskId,
        'opposite_task_id': oppositeTaskId,
        'link_id': linkId
      },
    );
    return statusCode;
  }

  Future<TaskLinkModel> getTaskLinkById(int taskLinkId) async {
    final TaskLinkModel link = await KanboardAPI().getObject<TaskLinkModel>(
      command: taskLinkCommands[TaskLinkProcedures.getById],
      params: {'task_link_id': taskLinkId},
    );
    return link;
  }

  Future<List<TaskLinkModel>> getAllLinksForTask(int taskId) async {
    final List<TaskLinkModel> links =
        await KanboardAPI().getObjectList<TaskLinkModel>(
      command: taskLinkCommands[TaskLinkProcedures.getAll],
      params: {'task_id': taskId},
    );
    return links;
  }

  Future<bool> updateTaskLink({
    @required int taskLinkId,
    @required int taskId,
    @required int oppositeTaskId,
    @required int linkId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: taskLinkCommands[TaskLinkProcedures.create],
      params: {
        'task_link_id': taskLinkId,
        'task_id': taskId,
        'opposite_task_id': oppositeTaskId,
        'link_id': linkId
      },
    );
    return status;
  }

  Future<bool> removeTaskLink(int taskLinkId) async {
    final bool status = await KanboardAPI().getBool(
      command: taskLinkCommands[TaskLinkProcedures.remove],
      params: {'task_link_id': taskLinkId},
    );
    return status;
  }
}
