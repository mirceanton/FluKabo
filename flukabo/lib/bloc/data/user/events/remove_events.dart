import '../user_bloc.dart';

class DeleteEvent extends UserEvent {
  final int userId;

  const DeleteEvent({this.userId});

  @override
  List<Object> get props => [userId];
}
