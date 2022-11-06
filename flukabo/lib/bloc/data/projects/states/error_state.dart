import '../projects_bloc.dart';

class ProjectError extends ProjectsState {
  final String errmsg; // error message
  const ProjectError(this.errmsg);

  @override
  List<Object> get props => [errmsg];
}
