import '../projects_bloc.dart';

class DeleteProjectEvent extends ProjectsEvent {
  final int id;

  const DeleteProjectEvent(this.id);

  @override
  List<Object> get props => [id];
}
