import '../../../../data/models/models.dart';
import '../tasks_bloc.dart';

class CreateTask extends TasksEvent {
  final TaskModel task;

  const CreateTask(this.task);

  @override
  List<Object> get props => [task];
}
