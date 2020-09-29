import '../projects_bloc.dart';

class DeleteProjectEvent extends ProjectsEvent {
  final int projectId;

  const DeleteProjectEvent(this.projectId);

  @override
  List<Object> get props => [projectId];
}
