import 'package:flukabo/data/models/user.dart';
import '../users_bloc.dart';

abstract class UpdateEvent extends UserEvent {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UpdateEvent {
  final UserModel updatedUser;

  const UpdateUserEvent({this.updatedUser});

  @override
  List<Object> get props => [updatedUser];
}

class EnableUserEvent extends UpdateEvent {
  final int userId;

  const EnableUserEvent({this.userId});

  @override
  List<Object> get props => [userId];
}

class DisableUserEvent extends UpdateEvent {
  final int userId;

  const DisableUserEvent({this.userId});

  @override
  List<Object> get props => [userId];
}
