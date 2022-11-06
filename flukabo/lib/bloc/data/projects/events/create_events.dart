import '../../../../data/models/models.dart';
import '../projects_bloc.dart';

class CreateProject extends ProjectsEvent {
  final ProjectModel project;

  const CreateProject(this.project);

  @override
  List<Object> get props => [project];
}
