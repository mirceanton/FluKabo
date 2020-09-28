import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../projects_bloc.dart';

abstract class UpdateEvent extends ProjectsEvent {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class UpdateProjectEvent extends UpdateEvent {
  final ProjectModel project;

  const UpdateProjectEvent(this.project);

  @override
  List<Object> get props => [project];
}

///
/// ---- Project Enable/Disable ----
///
class DisableProjectEvent extends UpdateEvent {
  final int projectId;

  const DisableProjectEvent(this.projectId);

  @override
  List<Object> get props => [projectId];
}

class EnableProjectEvent extends UpdateEvent {
  final int projectId;

  const EnableProjectEvent(this.projectId);

  @override
  List<Object> get props => [projectId];
}

///
/// ---- Project PUBLIC ACCESS ----
///
class EnablePublicAccessEvent extends UpdateEvent {
  final int projectId;

  const EnablePublicAccessEvent(this.projectId);

  @override
  List<Object> get props => [projectId];
}

class DisablePublicAccessEvent extends UpdateEvent {
  final int projectId;

  const DisablePublicAccessEvent(this.projectId);

  @override
  List<Object> get props => [projectId];
}

///
/// ---- Project USERS ----
///
class AddUserToProjectEvent extends UpdateEvent {
  final int projectId;
  final int userId;
  final String userRole;

  const AddUserToProjectEvent({
    @required this.projectId,
    @required this.userId,
    @required this.userRole,
  });

  @override
  List<Object> get props => [projectId, userId, userRole];
}

class ChangeUserRoleEvent extends UpdateEvent {
  final int projectId;
  final int userId;
  final String userRole;

  const ChangeUserRoleEvent({
    @required this.projectId,
    @required this.userId,
    @required this.userRole,
  });

  @override
  List<Object> get props => [projectId, userId, userRole];
}

class RemoveUserFromProjectEvent extends UpdateEvent {
  final int projectId;
  final int userId;

  const RemoveUserFromProjectEvent({
    @required this.projectId,
    @required this.userId,
  });

  @override
  List<Object> get props => [projectId, userId];
}

///
/// ---- Project GROUPS ----
///
class AddGroupToProjectEvent extends UpdateEvent {
  final int projectId;
  final int groupId;
  final String groupRole;

  const AddGroupToProjectEvent({
    @required this.projectId,
    @required this.groupId,
    @required this.groupRole,
  });

  @override
  List<Object> get props => [projectId, groupId, groupRole];
}

class ChangeGroupRoleEvent extends UpdateEvent {
  final int projectId;
  final int groupId;
  final String groupRole;

  const ChangeGroupRoleEvent({
    @required this.projectId,
    @required this.groupId,
    @required this.groupRole,
  });

  @override
  List<Object> get props => [projectId, groupId, groupRole];
}

class RemoveGroupFromProjectEvent extends UpdateEvent {
  final int projectId;
  final int groupId;

  const RemoveGroupFromProjectEvent({
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
class AddMetadataEvent extends UpdateEvent {
  final int projectId;
  final String key;
  final String value;

  const AddMetadataEvent({
    @required this.projectId,
    @required this.key,
    @required this.value,
  });

  @override
  List<Object> get props => [projectId, key, value];
}

class RemoveMetadataEvent extends UpdateEvent {
  final int projectId;
  final String key;

  const RemoveMetadataEvent({
    @required this.projectId,
    @required this.key,
  });

  @override
  List<Object> get props => [projectId, key];
}
