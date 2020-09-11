import 'package:flukabo/data/models/subtask.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/subtask_procedures.dart';
import 'package:flutter/cupertino.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the subtask management
///
/// It includes the following functionality:
///   - Create Subtask
///   - Update Subtask
///   - Remove Subtask
///   - Individual Subtask retrieval based on id
///   - Bulk Subtask retrieval based on task id
///
class SubtaskRepository {
  static final SubtaskRepository _instance = SubtaskRepository._constructor();

  factory SubtaskRepository() => _instance;
  SubtaskRepository._constructor(); // empty constructor

  Future<int> createSubtask({
    @required int taskId,
    @required String title,
    int userId,
    int timeEstimated,
    int timeSpent,
    int status,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: subtaskCommands[SubtaskProcedures.create],
      params: {
        'task_id': taskId,
        'title': title,
        'user_id': userId ?? '',
        'time_estimated': timeEstimated ?? 0,
        'time_spent': timeSpent ?? 0,
        'status': status ?? 0,
      },
    );
    return statusCode;
  }

  Future<SubtaskModel> getSubtaskById(int subtaskId) async {
    final SubtaskModel subtask = await KanboardAPI().getObject<SubtaskModel>(
      command: subtaskCommands[SubtaskProcedures.getById],
      params: {'subtask_id': subtaskId},
    );
    return subtask;
  }

  Future<List<SubtaskModel>> getAllSubtasksForTask(int taskId) async {
    final List<SubtaskModel> subtasks =
        await KanboardAPI().getObjectList<SubtaskModel>(
      command: subtaskCommands[SubtaskProcedures.getAll],
      params: {'task_id': taskId},
    );
    return subtasks;
  }

  Future<bool> updateSubtask({
    @required int subtaskId,
    @required int taskId,
    String title,
    int userId,
    int timeEstimated,
    int timeSpent,
    int subtaskStatus,
  }) async {
    final SubtaskModel subtask = await getSubtaskById(subtaskId);
    final bool status = await KanboardAPI().getBool(
      command: subtaskCommands[SubtaskProcedures.create],
      params: {
        'id': subtaskId,
        'task_id': taskId,
        'title': title ?? subtask.title,
        'user_id': userId ?? subtask.userId,
        'time_estimated': timeEstimated ?? subtask.timeEstimated,
        'time_spent': timeSpent ?? subtask.timeSpent,
        'status': subtaskStatus ?? subtask.status,
      },
    );
    return status;
  }

  Future<bool> removeSubtask(int subtaskId) async {
    final bool status = await KanboardAPI().getBool(
      command: subtaskCommands[SubtaskProcedures.remove],
      params: {'subtask_id': subtaskId},
    );
    return status;
  }
}
