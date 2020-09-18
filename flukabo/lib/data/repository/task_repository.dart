import 'package:flutter/material.dart';

import '../../res/kanboard/api_procedures/task_procedures.dart';
import '../models/task.dart';
import '../singletons/kanboard_api_client.dart';
import 'kanboard_repository.dart';
import 'project_repository.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// tasks management
///
/// It includes the following functionality:
///   - Task creation
///   - Task update
///   - Task removal
///   - Individual Task retrieval (based on either reference or id)
///   - Bulk Tasks retrieval (all, all overdue, overdue by project)
///   - Task open/close
///
class TaskRepository {
  static final TaskRepository _instance = TaskRepository._constructor();

  factory TaskRepository() => _instance;
  TaskRepository._constructor(); // empty constructor

  Future<int> createTask({
    @required String title,
    @required int projectId,
    String colorId,
    int columnId,
    int ownerId,
    int creatorId,
    String dateDue,
    String description,
    int categoryId,
    int complexity, // score
    int swimlaneId,
    int priority,
    int recurrenceStatus,
    int recurrenceTrigger,
    int recurrenceFactor,
    int recurrenceTimeframe,
    int recurrenceBasedate,
    String reference,
    List<String> tags,
    String dateStarted,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: taskCommands[TaskProcedures.create],
      params: {
        'title': title,
        'project_id': projectId,
        'color_id': colorId ?? KanboardRepository().defaultTaskColor,
        'column_id': columnId ?? '',
        'owner_id': ownerId ?? '',
        'creator_id': creatorId ?? '',
        'date_due': dateDue ?? '',
        'decription': description ?? '',
        'category_id': categoryId,
        'score': complexity ?? '0',
        'swimlane_id': swimlaneId ?? '',
        'priority': priority ??
            (await ProjectRepository().getProjectById(projectId))
                .priorityDefault,
        'recurrence_status': recurrenceStatus ?? '0',
        'recurrence_trigger': recurrenceTrigger ?? '0',
        'recurrence_factor': recurrenceFactor ?? '0',
        'recurrence_timeframe': recurrenceTimeframe ?? '0',
        'recurrence_basedate': recurrenceBasedate ?? '0',
        'reference': reference ?? '',
        'tags': tags ?? '',
        'date_started': dateStarted ?? '0',
      },
    );
    return statusCode;
  }

  Future<TaskModel> getTaskById(int taskId) async {
    final TaskModel task = await KanboardAPI().getObject<TaskModel>(
      command: taskCommands[TaskProcedures.getById],
      params: {'task_id': taskId},
    );
    return task;
  }

  Future<TaskModel> getTaskByReference({
    @required int projectId,
    @required String reference,
  }) async {
    final TaskModel task = await KanboardAPI().getObject<TaskModel>(
      command: taskCommands[TaskProcedures.getById],
      params: {
        'project_id': projectId,
        'reference': reference,
      },
    );
    return task;
  }

  Future<List<TaskModel>> getAllTasks({
    @required int projectId,
    @required bool isActive,
  }) async {
    final List<TaskModel> tasks = await KanboardAPI().getObjectList<TaskModel>(
      command: taskCommands[TaskProcedures.getAll],
      params: {
        'project_id': projectId,
        'status_id': isActive ? 1 : 0,
      },
    );
    return tasks;
  }

  Future<List<TaskModel>> getAllOverdueTasks() async {
    final List<TaskModel> tasks = await KanboardAPI().getObjectList<TaskModel>(
      command: taskCommands[TaskProcedures.getAllOverdue],
      params: null,
    );
    return tasks;
  }

  Future<List<TaskModel>> getOverdueTasksByProject(int projectId) async {
    final List<TaskModel> tasks = await KanboardAPI().getObjectList<TaskModel>(
      command: taskCommands[TaskProcedures.getOverdueByProject],
      params: {'project_id': projectId},
    );
    return tasks;
  }

  Future<bool> updateTask({
    @required int taskId,
    String title,
    String colorId,
    int ownerId,
    String dateDue,
    String description,
    int categoryId,
    int complexity,
    int priority,
    int recurrenceStatus,
    int recurrenceTrigger,
    int recurrenceFactor,
    int recurrenceTimeframe,
    int recurrenceBasedate,
    String reference,
    List<String> tags,
    String dateStarted,
  }) async {
    final TaskModel task = await getTaskById(taskId);
    final bool status = await KanboardAPI().getBool(
      command: taskCommands[TaskProcedures.create],
      params: {
        'task_id': taskId,
        'title': title ?? task.title,
        'color_id': colorId ?? task.colorId,
        'owner_id': ownerId ?? task.ownerId,
        'date_due': dateDue ?? task.dateDue,
        'decription': description ?? task.description,
        'category_id': categoryId ?? task.categoryId,
        'score': complexity ?? task.complexity,
        'priority': priority ?? task.priority,
        'recurrence_status': recurrenceStatus ?? task.recurrenceStatus,
        'recurrence_trigger': recurrenceTrigger ?? task.recurrenceTrigger,
        'recurrence_factor': recurrenceFactor ?? task.recurrenceFactor,
        'recurrence_timeframe': recurrenceTimeframe ?? task.recurrenceTimeframe,
        'recurrence_basedate': recurrenceBasedate ?? task.recurrenceBasedate,
        'reference': reference ?? task.reference,
        'tags': tags ?? task.tags,
        'date_started': dateStarted ?? task.dateStarted,
      },
    );
    return status;
  }

  Future<bool> openTask(int taskId) async {
    final bool status = await KanboardAPI().getBool(
      command: taskCommands[TaskProcedures.open],
      params: {'task_id': taskId},
    );
    return status;
  }

  Future<bool> closeTask(int taskId) async {
    final bool status = await KanboardAPI().getBool(
      command: taskCommands[TaskProcedures.close],
      params: {'task_id': taskId},
    );
    return status;
  }

  Future<bool> moveTaskToPosition({
    @required int projectId,
    @required int taskId,
    @required int columnId,
    @required int position,
    @required int swimlaneId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: taskCommands[TaskProcedures.moveToPosition],
      params: {
        'project_id': projectId,
        'task_id': taskId,
        'column_id': columnId,
        'swimlane_id': swimlaneId,
        'position': position,
      },
    );
    return status;
  }

  Future<bool> moveTaskToProject({
    @required int taskId,
    @required int projectId,
    @required int swimlaneId,
    @required int columnId,
    @required int categoryId,
    @required int ownerId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: taskCommands[TaskProcedures.moveToPosition],
      params: {
        'project_id': projectId,
        'task_id': taskId,
        'column_id': columnId,
        'swimlane_id': swimlaneId,
        'category_id': categoryId,
        'owner_id': ownerId,
      },
    );
    return status;
  }

  Future<bool> cloneTaskToProject({
    @required int taskId,
    @required int projectId,
    @required int swimlaneId,
    @required int columnId,
    @required int categoryId,
    @required int ownerId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: taskCommands[TaskProcedures.cloneToProject],
      params: {
        'project_id': projectId,
        'task_id': taskId,
        'column_id': columnId,
        'swimlane_id': swimlaneId,
        'category_id': categoryId,
        'owner_id': ownerId,
      },
    );
    return status;
  }

  Future<bool> removeTask(int taskId) async {
    final bool status = await KanboardAPI().getBool(
      command: taskCommands[TaskProcedures.remove],
      params: {'task_id': taskId},
    );
    return status;
  }

  Future<List<TaskModel>> searchTasks({
    @required int projectId,
    @required String query,
  }) async {
    final List<TaskModel> tasks = await KanboardAPI().getObjectList<TaskModel>(
      command: taskCommands[TaskProcedures.search],
      params: {
        'project_id': projectId,
        'query': query,
      },
    );
    return tasks;
  }
}
