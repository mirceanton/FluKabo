import '../projects_bloc.dart';

abstract class ReadEvent extends ProjectsEvent {
  const ReadEvent();

  @override
  List<Object> get props => [];
}

///
/// ---- Fetch Project ----
///
class FetchByIdEvent extends ReadEvent {
  final int projectId;

  const FetchByIdEvent({this.projectId});

  @override
  List<Object> get props => [projectId];
}

class FetchByNameEvent extends ReadEvent {
  final String projectName;

  const FetchByNameEvent({this.projectName});

  @override
  List<Object> get props => [projectName];
}

class FetchAllEvent extends ReadEvent {
  const FetchAllEvent();

  @override
  List<Object> get props => [];
}

///
/// ---- Project FEED ----
///
class FetchFeedEvent extends ReadEvent {
  final int projectId;

  const FetchFeedEvent({this.projectId});

  @override
  List<Object> get props => [projectId];
}

///
/// ---- Project USERS ----
///
class FetchUsersEvent extends ReadEvent {
  final int projectId;

  const FetchUsersEvent({this.projectId});

  @override
  List<Object> get props => [projectId];
}

class FetchAssignableUsersEvent extends ReadEvent {
  final int projectId;

  const FetchAssignableUsersEvent({this.projectId});

  @override
  List<Object> get props => [projectId];
}

class FetchUserRoleEvent extends ReadEvent {
  final int projectId;
  final int userId;

  const FetchUserRoleEvent({this.projectId, this.userId});

  @override
  List<Object> get props => [projectId, userId];
}

///
/// ---- Project METADATA ----
///
class FetchMetadataByKeyEvent extends ReadEvent {
  final int projectId;
  final String key;

  const FetchMetadataByKeyEvent({this.projectId, this.key});
  @override
  List<Object> get props => [projectId, key];
}

class FetchAllMetadataEvent extends ReadEvent {
  final int projectId;

  const FetchAllMetadataEvent({this.projectId});

  @override
  List<Object> get props => [projectId];
}
