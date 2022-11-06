import '../users_bloc.dart';

class DeleteUserEvent extends UserEvent {
  final int userId;

  const DeleteUserEvent({this.userId});

  @override
  List<Object> get props => [userId];
}
