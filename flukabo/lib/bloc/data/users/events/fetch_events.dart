import '../users_bloc.dart';

abstract class ReadUserEvent extends UserEvent {
  const ReadUserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserById extends ReadUserEvent {
  final int userId;

  const FetchUserById({this.userId});

  @override
  List<Object> get props => [userId];
}

class FetchUserByUsername extends ReadUserEvent {
  final String username;

  const FetchUserByUsername({this.username});

  @override
  List<Object> get props => [username];
}

class FetchAllUsers extends ReadUserEvent {
  const FetchAllUsers();

  @override
  List<Object> get props => [];
}

class FetchGroups extends ReadUserEvent {
  final int userId;

  const FetchGroups({this.userId});

  @override
  List<Object> get props => [userId];
}
