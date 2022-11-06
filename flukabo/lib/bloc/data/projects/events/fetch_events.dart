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
abstract class FetchSingleProject extends ReadProjectEvent {
  const FetchSingleProject();

  @override
  List<Object> get props => [];
}

class FetchProjectById extends FetchSingleProject {
  final int id;

  const FetchProjectById(this.id);

  @override
  List<Object> get props => [id];
}

class FethchProjectByName extends FetchSingleProject {
  final String name;

  const FethchProjectByName({this.name});

  @override
  List<Object> get props => [name];
}

abstract class FetchProjectList extends ReadProjectEvent {
  const FetchProjectList();

  @override
  List<Object> get props => [];
}

class FetchAllProjects extends FetchProjectList {
  const FetchAllProjects();

  @override
  List<Object> get props => [];
}

class FetchPersonalProjects extends FetchProjectList {
  const FetchPersonalProjects();

  @override
  List<Object> get props => [];
}

class FetchPublicProjects extends FetchProjectList {
  const FetchPublicProjects();

  @override
  List<Object> get props => [];
}

class FetchStarredProjects extends FetchProjectList {
  const FetchStarredProjects();

  @override
  List<Object> get props => [];
}

///
/// ---- Project FEED ----
///
class FetchFeedForProject extends ReadProjectEvent {
  final int id;

  const FetchFeedForProject(this.id);

  @override
  List<Object> get props => [id];
}

///
/// ---- Project USERS ----
///
abstract class FetchUserList extends ReadProjectEvent {
  const FetchUserList();
  @override
  List<Object> get props => [];
}

class FetchProjectUsers extends FetchUserList {
  final int id;

  const FetchProjectUsers(this.id);

  @override
  List<Object> get props => [id];
}

class FetchAssignableUsers extends FetchUserList {
  final int id;

  const FetchAssignableUsers(this.id);

  @override
  List<Object> get props => [id];
}

class FetchUserRole extends ReadProjectEvent {
  final int id;
  final int userId;

  const FetchUserRole({
    @required this.id,
    @required this.userId,
  });

  @override
  List<Object> get props => [id, userId];
}

///
/// ---- Project METADATA ----
///
class FetchMetadataByKey extends ReadProjectEvent {
  final int id;
  final String key;

  const FetchMetadataByKey({
    @required this.id,
    @required this.key,
  });
  @override
  List<Object> get props => [id, key];
}

class FetchAllMetadata extends ReadProjectEvent {
  final int id;

  const FetchAllMetadata(this.id);

  @override
  List<Object> get props => [id];
}
