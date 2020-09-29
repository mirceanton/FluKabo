import '../tasks_bloc.dart';

class TaskError extends TasksState {
  final String errmsg; // error message
  const TaskError(this.errmsg);

  @override
  List<Object> get props => [errmsg];
}
