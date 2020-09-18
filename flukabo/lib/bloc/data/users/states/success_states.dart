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
class UserCreatedState extends SuccessState {
  final UserModel user;

  const UserCreatedState({this.user});

  @override
  List<Object> get props => [user];
}

///
/// ---- SUCCES STATES FOR FETCH EVENTS ----
///
/// The SuccessState associated to [FetchByIdEvent], [FetchByUsernameEvent]
class UserFetchedState extends SuccessState {
  final UserModel user;

  const UserFetchedState({this.user});

  @override
  List<Object> get props => [user];
}

/// The SuccessState associated to [FetchAllEvent]
class UsersFetchedState extends SuccessState {
  final List<UserModel> users;

  const UsersFetchedState({this.users});

  @override
  List<Object> get props => [users];
}

/// The SuccessState associated to [FetchGroups]
class GroupsFetchedState extends SuccessState {
  final List<GroupModel> groups;

  const GroupsFetchedState({this.groups});

  @override
  List<Object> get props => [groups];
}

///
/// ---- SUCCES STATES FOR UPDATE EVENTS ----
///
/// The SuccessState associated to [UpdateEvent], [EnableEvent], [DisableEvent]
class UserUpdatedState extends SuccessState {
  final bool wasSuccessful;

  const UserUpdatedState({this.wasSuccessful});

  @override
  List<Object> get props => [wasSuccessful];
}

///
/// ---- SUCCES STATES FOR DELETE EVENTS ----
///
/// The SuccessState associated to [RemoveEvent]
class UserRemovedState extends SuccessState {
  final bool wasSuccessful;

  const UserRemovedState({this.wasSuccessful});

  @override
  List<Object> get props => [wasSuccessful];
}
