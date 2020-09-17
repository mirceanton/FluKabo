import 'package:flukabo/data/models/group.dart';
import 'package:flukabo/data/models/user.dart';

import '../users_bloc.dart';

abstract class SuccessState extends UserState {
  const SuccessState();

  @override
  List<Object> get props => [];
}

/// The SuccessState associated to [CreateEvent]
class UserCreatedState extends SuccessState {
  final UserModel user;

  const UserCreatedState({this.user});

  @override
  List<Object> get props => [user];
}

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

/// The SuccessState associated to [UpdateEvent], [EnableEvent], [DisableEvent]
class UserUpdatedState extends SuccessState {
  final bool wasSuccessful;

  const UserUpdatedState({this.wasSuccessful});

  @override
  List<Object> get props => [wasSuccessful];
}

/// The SuccessState associated to [RemoveEvent]
class UserRemovedState extends SuccessState {
  final bool wasSuccessful;

  const UserRemovedState({this.wasSuccessful});

  @override
  List<Object> get props => [wasSuccessful];
}
