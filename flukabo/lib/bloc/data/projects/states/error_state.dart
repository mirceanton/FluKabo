import '../projects_bloc.dart';

class ErrorState extends ProjectsState {
  final String errmsg; // error message
  const ErrorState(this.errmsg);

  @override
  List<Object> get props => [errmsg];
}
