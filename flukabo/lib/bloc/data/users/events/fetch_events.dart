import '../users_bloc.dart';

abstract class ReadEvent extends UserEvent {
  const ReadEvent();

  @override
  List<Object> get props => [];
}

class FetchByIdEvent extends ReadEvent {
  final int userId;

  const FetchByIdEvent({this.userId});

  @override
  List<Object> get props => [userId];
}

class FetchByUsernameEvent extends ReadEvent {
  final String username;

  const FetchByUsernameEvent({this.username});

  @override
  List<Object> get props => [username];
}

class FetchAllEvent extends ReadEvent {
  const FetchAllEvent();

  @override
  List<Object> get props => [];
}

class FetchGroupsEvent extends ReadEvent {
  final int userId;

  const FetchGroupsEvent({this.userId});

  @override
  List<Object> get props => [userId];
}
