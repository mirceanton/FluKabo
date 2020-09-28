import 'package:flutter/material.dart';

import '../tasks_bloc.dart';

abstract class ReadEvent extends TasksEvent {
  const ReadEvent();

  @override
  List<Object> get props => [];
}

abstract class ReadObjectEvent extends ReadEvent {
  const ReadObjectEvent();
  @override
  List<Object> get props => [];
}

class FetchByIdEvent extends ReadObjectEvent {
  final int taskId;

  const FetchByIdEvent({@required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class FetchByReferenceEvent extends ReadObjectEvent {
  final int projectId;
  final String reference;

  const FetchByReferenceEvent({
    @required this.projectId,
    @required this.reference,
  });

  @override
  List<Object> get props => [projectId, reference];
}

abstract class ReadObjectListEvent extends ReadEvent {
  const ReadObjectListEvent();
  @override
  List<Object> get props => [];
}

class FetchAllForProjectEvent extends ReadObjectListEvent {
  final int projectId;
  final bool isActive;

  const FetchAllForProjectEvent({
    @required this.projectId,
    @required this.isActive,
  });

  @override
  List<Object> get props => [projectId, isActive];
}

class FetchAllOverdueEvent extends ReadObjectListEvent {
  const FetchAllOverdueEvent();

  @override
  List<Object> get props => [];
}

class FetchOverdueForProjectEvent extends ReadObjectListEvent {
  final int projectId;

  const FetchOverdueForProjectEvent({@required this.projectId});

  @override
  List<Object> get props => [projectId];
}

class SearchEvent extends ReadObjectListEvent {
  final int projectId;
  final String query;

  const SearchEvent({
    @required this.projectId,
    @required this.query,
  });

  @override
  List<Object> get props => [projectId, query];
}
