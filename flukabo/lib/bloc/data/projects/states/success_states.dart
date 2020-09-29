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
class ProjectCreated extends SuccessState {
  final ProjectModel project;

  const ProjectCreated(this.project);

  @override
  List<Object> get props => [project];
}

///
/// ---- SUCCES STATES FOR FETCH EVENTS ----
///
/// The SuccessState associated to [FetchByIdEvent], [FetchByNameEvent]
class ProjectFetched extends SuccessState {
  final ProjectModel project;

  const ProjectFetched(this.project);

  @override
  List<Object> get props => [project];
}

/// The SuccessState associated to [FetchAllEvent]
class ProjectListFetched extends SuccessState {
  final List<ProjectModel> projects;

  const ProjectListFetched(this.projects);

  @override
  List<Object> get props => [projects];
}

/// The SuccessState associated to [FetchFeedEvent]
class FeedFetched extends SuccessState {
  final List<EventModel> feed;

  const FeedFetched(this.feed);

  @override
  List<Object> get props => [feed];
}

/// The SuccessState associated to [FetchUsersEvent], [FetchAssignableUsersEvent]
class UserListFetched extends SuccessState {
  final List<UserModel> users;

  const UserListFetched(this.users);

  @override
  List<Object> get props => [users];
}

/// The SuccessState associated to [FetchUserRoleEvent]
class UserRoleFetched extends SuccessState {
  final String role;

  const UserRoleFetched(this.role);

  @override
  List<Object> get props => [role];
}

/// The SuccessState associated to [FetchMetadataByKeyEvent]
class MetadataFetchedByKey extends SuccessState {
  final String value;

  const MetadataFetchedByKey(this.value);

  @override
  List<Object> get props => [value];
}

/// The SuccessState associated to [FetchAllMetadataEvent]
class MetadataFetched extends SuccessState {
  final Map<String, String> metadata;

  const MetadataFetched(this.metadata);

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
class ProjectUpdated extends SuccessState {
  final bool wasSuccessful;

  // ignore: avoid_positional_boolean_parameters
  const ProjectUpdated(this.wasSuccessful);

  @override
  List<Object> get props => [wasSuccessful];
}

///
/// ---- SUCCES STATES FOR DELETE EVENTS ----
///
/// The SuccessState associated to [DeleteEvent]
class ProjectRemoved extends SuccessState {
  final bool wasSuccessful;

  // ignore: avoid_positional_boolean_parameters
  const ProjectRemoved(this.wasSuccessful);

  @override
  List<Object> get props => [wasSuccessful];
}
