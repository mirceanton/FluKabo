import '../tasks_bloc.dart';

class ErrorState extends TasksState {
  final String errmsg; // error message
  const ErrorState({this.errmsg});

  @override
  List<Object> get props => [errmsg];
}
