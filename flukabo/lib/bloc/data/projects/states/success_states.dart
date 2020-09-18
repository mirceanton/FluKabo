import '../../../../data/models/event.dart';
import '../../../../data/models/models.dart';
import '../../../../data/models/project.dart';

import '../projects_bloc.dart';

abstract class SuccessState extends ProjectsState {
  const SuccessState();

  @override
  List<Object> get props => [];
}

///
/// ---- SUCCES STATES FOR CREATE EVENTS ----
///
/// The SuccessState associated to [CreateEvent]
class ProjectCreatedState extends SuccessState {
  final ProjectModel project;

  const ProjectCreatedState({this.project});

  @override
  List<Object> get props => [project];
}

///
/// ---- SUCCES STATES FOR FETCH EVENTS ----
///
/// The SuccessState associated to [FetchByIdEvent], [FetchByNameEvent]
class ProjectFetchedState extends SuccessState {
  final ProjectModel project;

  const ProjectFetchedState({this.project});

  @override
  List<Object> get props => [project];
}

/// The SuccessState associated to [FetchAllEvent]
class ProjectsFetchedState extends SuccessState {
  final List<ProjectModel> projects;

  const ProjectsFetchedState({this.projects});

  @override
  List<Object> get props => [projects];
}

/// The SuccessState associated to [FetchFeedEvent]
class FeedFetchedState extends SuccessState {
  final List<EventModel> feed;

  const FeedFetchedState({this.feed});

  @override
  List<Object> get props => [feed];
}

/// The SuccessState associated to [FetchUsersEvent], [FetchAssignableUsersEvent]
class UsersFetchedState extends SuccessState {
  final List<UserModel> users;

  const UsersFetchedState({this.users});

  @override
  List<Object> get props => [users];
}

/// The SuccessState associated to [FetchUserRoleEvent]
class UserRoleFetchedState extends SuccessState {
  final String role;

  const UserRoleFetchedState({this.role});

  @override
  List<Object> get props => [role];
}

/// The SuccessState associated to [FetchMetadataByKeyEvent]
class MetadataFetchedByKeyState extends SuccessState {
  final String value;

  const MetadataFetchedByKeyState({this.value});

  @override
  List<Object> get props => [value];
}

/// The SuccessState associated to [FetchAllMetadataEvent]
class MetadataFetchedState extends SuccessState {
  final Map<String, String> metadata;

  const MetadataFetchedState({this.metadata});

  @override
  List<Object> get props => [metadata];
}

///
/// ---- SUCCES STATES FOR UPDATE EVENTS ----
///
/// The SuccessState associated to:
///   - [UpdateProjectEvent]
///   - [EnableProjectEvent]
///   - [DisableProjectEvent]
///   - [EnablePublicAccessEvent]
///   - [DisablePublicAccessEvent]
///   - [AddUserToProjectEvent]
///   - [ChangeUserRoleEvent]
///   - [RemoveUserFromProjectEvent]
///   - [AddGroupToProjectEvent]
///   - [ChangeGroupRoleEvent]
///   - [RemoveGroupFromProjectEvent]
///   - [AddMetadataEvent]
///   - [RemoveMetadataEvent]
///
class ProjectUpdatedState extends SuccessState {
  final bool wasSuccessful;

  const ProjectUpdatedState({this.wasSuccessful});

  @override
  List<Object> get props => [wasSuccessful];
}

///
/// ---- SUCCES STATES FOR DELETE EVENTS ----
///
/// The SuccessState associated to [DeleteEvent]
class ProjectRemovedState extends SuccessState {
  final bool wasSuccessful;

  const ProjectRemovedState({this.wasSuccessful});

  @override
  List<Object> get props => [wasSuccessful];
}
