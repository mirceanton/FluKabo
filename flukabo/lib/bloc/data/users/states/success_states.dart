import '../../../../data/models/group.dart';
import '../../../../data/models/user.dart';

import '../users_bloc.dart';

abstract class SuccessState extends UserState {
  const SuccessState();

  @override
  List<Object> get props => [];
}

///
/// ---- SUCCES STATES FOR CREATE EVENTS ----
///
/// The SuccessState associated to [CreateEvent]
class UserCreated extends SuccessState {
  final UserModel user;

  const UserCreated({this.user});

  @override
  List<Object> get props => [user];
}

///
/// ---- SUCCES STATES FOR FETCH EVENTS ----
///
/// The SuccessState associated to [FetchByIdEvent], [FetchByUsernameEvent]
class UserFetched extends SuccessState {
  final UserModel user;

  const UserFetched({this.user});

  @override
  List<Object> get props => [user];
}

/// The SuccessState associated to [FetchAllEvent]
class UserListFetched extends SuccessState {
  final List<UserModel> users;

  const UserListFetched({this.users});

  @override
  List<Object> get props => [users];
}

/// The SuccessState associated to [FetchGroups]
class GroupListFetched extends SuccessState {
  final List<GroupModel> groups;

  const GroupListFetched({this.groups});

  @override
  List<Object> get props => [groups];
}

///
/// ---- SUCCES STATES FOR UPDATE EVENTS ----
///
/// The SuccessState associated to [UpdateEvent], [EnableEvent], [DisableEvent]
class UserUpdated extends SuccessState {
  final bool wasSuccessful;

  const UserUpdated({this.wasSuccessful});

  @override
  List<Object> get props => [wasSuccessful];
}

///
/// ---- SUCCES STATES FOR DELETE EVENTS ----
///
/// The SuccessState associated to [RemoveEvent]
class UserRemoved extends SuccessState {
  final bool wasSuccessful;

  const UserRemoved({this.wasSuccessful});

  @override
  List<Object> get props => [wasSuccessful];
}
