import 'package:flutter/material.dart';

import '../projects_bloc.dart';

abstract class ReadProjectEvent extends ProjectsEvent {
  const ReadProjectEvent();

  @override
  List<Object> get props => [];
}

///
/// ---- Fetch Project ----
///
class FetchProjectById extends ReadProjectEvent {
  final int projectId;

  const FetchProjectById(this.projectId);

  @override
  List<Object> get props => [projectId];
}

class FethchProjectByName extends ReadProjectEvent {
  final String projectName;

  const FethchProjectByName({this.projectName});

  @override
  List<Object> get props => [projectName];
}

class FetchAllProjects extends ReadProjectEvent {
  const FetchAllProjects();

  @override
  List<Object> get props => [];
}

///
/// ---- Project FEED ----
///
class FetchFeedForProject extends ReadProjectEvent {
  final int projectId;

  const FetchFeedForProject(this.projectId);

  @override
  List<Object> get props => [projectId];
}

///
/// ---- Project USERS ----
///
class FetchProjectUsers extends ReadProjectEvent {
  final int projectId;

  const FetchProjectUsers(this.projectId);

  @override
  List<Object> get props => [projectId];
}

class FetchAssignableUsers extends ReadProjectEvent {
  final int projectId;

  const FetchAssignableUsers(this.projectId);

  @override
  List<Object> get props => [projectId];
}

class FetchUserRole extends ReadProjectEvent {
  final int projectId;
  final int userId;

  const FetchUserRole({
    @required this.projectId,
    @required this.userId,
  });

  @override
  List<Object> get props => [projectId, userId];
}

///
/// ---- Project METADATA ----
///
class FetchMetadataByKey extends ReadProjectEvent {
  final int projectId;
  final String key;

  const FetchMetadataByKey({
    @required this.projectId,
    @required this.key,
  });
  @override
  List<Object> get props => [projectId, key];
}

class FetchAllMetadata extends ReadProjectEvent {
  final int projectId;

  const FetchAllMetadata(this.projectId);

  @override
  List<Object> get props => [projectId];
}
