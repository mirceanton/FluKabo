import '../../../../bloc/data/tasks/tasks_bloc.dart';
import '../../../../data/models/task.dart';

abstract class UpdateEvent extends TasksEvent {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class UpdateTaskEvent extends UpdateEvent {
  final TaskModel task;

  const UpdateTaskEvent({this.task});

  @override
  List<Object> get props => [task];
}

class OpenTaskEvent extends UpdateEvent {
  final int taskId;

  const OpenTaskEvent({this.taskId});

  @override
  List<Object> get props => [taskId];
}

class CloseTaskEvent extends UpdateEvent {
  final int taskId;

  const CloseTaskEvent({this.taskId});

  @override
  List<Object> get props => [taskId];
}

class MoveTaskWithinProjectEvent extends UpdateEvent {
  final int projectId, taskId, columnId, swimlaneId, position;

  const MoveTaskWithinProjectEvent({
    this.projectId,
    this.taskId,
    this.columnId,
    this.swimlaneId,
    this.position,
  });

  @override
  List<Object> get props => [projectId, taskId, columnId, swimlaneId, position];
}

class MoveTaskToProjectEvent extends UpdateEvent {
  final int projectId, taskId, swimlaneId, columnId, categoryId, ownerId;

  const MoveTaskToProjectEvent({
    this.projectId,
    this.taskId,
    this.swimlaneId,
    this.columnId,
    this.categoryId,
    this.ownerId,
  });

  @override
  List<Object> get props =>
      [projectId, taskId, swimlaneId, columnId, categoryId, ownerId];
}

class CloneTaskToProjectEvent extends UpdateEvent {
  final int projectId, taskId, swimlaneId, columnId, categoryId, ownerId;

  const CloneTaskToProjectEvent({
    this.projectId,
    this.taskId,
    this.swimlaneId,
    this.columnId,
    this.categoryId,
    this.ownerId,
  });

  @override
  List<Object> get props =>
      [projectId, taskId, swimlaneId, columnId, categoryId, ownerId];
}
