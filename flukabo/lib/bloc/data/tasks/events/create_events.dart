import '../../../../data/models/models.dart';
import '../tasks_bloc.dart';

class CreateEvent extends TasksEvent {
  final TaskModel task;

  const CreateEvent({this.task});

  @override
  List<Object> get props => [task];
}
