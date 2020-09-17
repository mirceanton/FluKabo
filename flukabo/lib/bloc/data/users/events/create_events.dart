import 'package:flukabo/data/models/user.dart';
import '../users_bloc.dart';

class CreateEvent extends UserEvent {
  final UserModel newUser;

  const CreateEvent({this.newUser});

  @override
  List<Object> get props => [newUser];
}
