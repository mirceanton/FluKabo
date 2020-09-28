import '../projects_bloc.dart';

class DeleteEvent extends ProjectsEvent {
  final int projectId;

  const DeleteEvent(this.projectId);

  @override
  List<Object> get props => [projectId];
}
