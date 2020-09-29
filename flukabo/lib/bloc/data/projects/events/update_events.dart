import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../projects_bloc.dart';

abstract class UpdateProjectEvent extends ProjectsEvent {
  const UpdateProjectEvent();

  @override
  List<Object> get props => [];
}

class UpdateProject extends UpdateProjectEvent {
  final ProjectModel project;

  const UpdateProject(this.project);

  @override
  List<Object> get props => [project];
}

///
/// ---- Project Enable/Disable ----
///
class DisableProject extends UpdateProjectEvent {
  final int projectId;

  const DisableProject(this.projectId);

  @override
  List<Object> get props => [projectId];
}

class EnableProject extends UpdateProjectEvent {
  final int projectId;

  const EnableProject(this.projectId);

  @override
  List<Object> get props => [projectId];
}

///
/// ---- Project PUBLIC ACCESS ----
///
class EnablePublicAccess extends UpdateProjectEvent {
  final int projectId;

  const EnablePublicAccess(this.projectId);

  @override
  List<Object> get props => [projectId];
}

class DisablePublicAccess extends UpdateProjectEvent {
  final int projectId;

  const DisablePublicAccess(this.projectId);

  @override
  List<Object> get props => [projectId];
}

///
/// ---- Project USERS ----
///
class AddUserToProject extends UpdateProjectEvent {
  final int projectId;
  final int userId;
  final String userRole;

  const AddUserToProject({
    @required this.projectId,
    @required this.userId,
    @required this.userRole,
  });

  @override
  List<Object> get props => [projectId, userId, userRole];
}

class ChangeUserRole extends UpdateProjectEvent {
  final int projectId;
  final int userId;
  final String userRole;

  const ChangeUserRole({
    @required this.projectId,
    @required this.userId,
    @required this.userRole,
  });

  @override
  List<Object> get props => [projectId, userId, userRole];
}

class RemoveUserFromProject extends UpdateProjectEvent {
  final int projectId;
  final int userId;

  const RemoveUserFromProject({
    @required this.projectId,
    @required this.userId,
  });

  @override
  List<Object> get props => [projectId, userId];
}

///
/// ---- Project GROUPS ----
///
class AddGroupToProject extends UpdateProjectEvent {
  final int projectId;
  final int groupId;
  final String groupRole;

  const AddGroupToProject({
    @required this.projectId,
    @required this.groupId,
    @required this.groupRole,
  });

  @override
  List<Object> get props => [projectId, groupId, groupRole];
}

class ChangeGroupRole extends UpdateProjectEvent {
  final int projectId;
  final int groupId;
  final String groupRole;

  const ChangeGroupRole({
    @required this.projectId,
    @required this.groupId,
    @required this.groupRole,
  });

  @override
  List<Object> get props => [projectId, groupId, groupRole];
}

class RemoveGroupFromProject extends UpdateProjectEvent {
  final int projectId;
  final int groupId;

  const RemoveGroupFromProject({
    @required this.projectId,
    @required this.groupId,
  });

  @override
  List<Object> get props => [projectId, groupId];
}

///
/// ---- Project METADATA ----
/// ---- Project METADATA ----
///
class AddMetadata extends UpdateProjectEvent {
  final int projectId;
  final String key;
  final String value;

  const AddMetadata({
    @required this.projectId,
    @required this.key,
    @required this.value,
  });

  @override
  List<Object> get props => [projectId, key, value];
}

class RemoveMetadata extends UpdateProjectEvent {
  final int projectId;
  final String key;

  const RemoveMetadata({
    @required this.projectId,
    @required this.key,
  });

  @override
  List<Object> get props => [projectId, key];
}
