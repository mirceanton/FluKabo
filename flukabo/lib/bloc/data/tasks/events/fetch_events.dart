import 'package:flutter/material.dart';

import '../tasks_bloc.dart';

abstract class ReadTaskEvent extends TasksEvent {
  const ReadTaskEvent();

  @override
  List<Object> get props => [];
}

abstract class ReadObjectEvent extends ReadTaskEvent {
  const ReadObjectEvent();
  @override
  List<Object> get props => [];
}

class FetchTaskById extends ReadObjectEvent {
  final int taskId;

  const FetchTaskById({@required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class FetchTaskByReference extends ReadObjectEvent {
  final int projectId;
  final String reference;

  const FetchTaskByReference({
    @required this.projectId,
    @required this.reference,
  });

  @override
  List<Object> get props => [projectId, reference];
}

abstract class ReadObjectListEvent extends ReadTaskEvent {
  const ReadObjectListEvent();
  @override
  List<Object> get props => [];
}

class FetchAllTasksForProject extends ReadObjectListEvent {
  final int projectId;
  final bool isActive;

  const FetchAllTasksForProject({
    @required this.projectId,
    @required this.isActive,
  });

  @override
  List<Object> get props => [projectId, isActive];
}

class FetchAllOverdueTasks extends ReadObjectListEvent {
  const FetchAllOverdueTasks();

  @override
  List<Object> get props => [];
}

class FetchAllOverdueTasksForProject extends ReadObjectListEvent {
  final int projectId;

  const FetchAllOverdueTasksForProject({@required this.projectId});

  @override
  List<Object> get props => [projectId];
}

class SearchForTask extends ReadObjectListEvent {
  final int projectId;
  final String query;

  const SearchForTask({
    @required this.projectId,
    @required this.query,
  });

  @override
  List<Object> get props => [projectId, query];
}
