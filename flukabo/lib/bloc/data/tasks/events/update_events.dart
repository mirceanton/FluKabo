import 'package:flutter/material.dart';

import '../../../../bloc/data/tasks/tasks_bloc.dart';
import '../../../../data/models/task.dart';

abstract class UpdateTaskEvent extends TasksEvent {
  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}

class UpdateTask extends UpdateTaskEvent {
  final TaskModel task;

  const UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class OpenTask extends UpdateTaskEvent {
  final int taskId;

  const OpenTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class CloseTask extends UpdateTaskEvent {
  final int taskId;

  const CloseTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class MoveTaskWithinProject extends UpdateTaskEvent {
  final int projectId, taskId, columnId, swimlaneId, position;

  const MoveTaskWithinProject({
    @required this.projectId,
    @required this.taskId,
    @required this.columnId,
    @required this.swimlaneId,
    @required this.position,
  });

  @override
  List<Object> get props => [projectId, taskId, columnId, swimlaneId, position];
}

class MoveTaskToProject extends UpdateTaskEvent {
  final int projectId, taskId, swimlaneId, columnId, categoryId, ownerId;

  const MoveTaskToProject({
    @required this.projectId,
    @required this.taskId,
    @required this.swimlaneId,
    @required this.columnId,
    @required this.categoryId,
    @required this.ownerId,
  });

  @override
  List<Object> get props =>
      [projectId, taskId, swimlaneId, columnId, categoryId, ownerId];
}

class CloneTaskToProject extends UpdateTaskEvent {
  final int projectId, taskId, swimlaneId, columnId, categoryId, ownerId;

  const CloneTaskToProject({
    @required this.projectId,
    @required this.taskId,
    @required this.swimlaneId,
    @required this.columnId,
    @required this.categoryId,
    @required this.ownerId,
  });

  @override
  List<Object> get props =>
      [projectId, taskId, swimlaneId, columnId, categoryId, ownerId];
}
