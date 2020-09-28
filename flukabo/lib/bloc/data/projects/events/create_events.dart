import '../../../../data/models/models.dart';
import '../projects_bloc.dart';

class CreateEvent extends ProjectsEvent {
  final ProjectModel project;

  const CreateEvent(this.project);

  @override
  List<Object> get props => [project];
}
