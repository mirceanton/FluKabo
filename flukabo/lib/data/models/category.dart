import '../../data/helpers/json_parser.dart';
import '../../data/models/abstract_model.dart';
import '../../data/models/project.dart';
import '../../data/repository/project_repository.dart';

class CategoryModel extends AbstractDataModel {
  int _id;
  String _name;
  int _projectId;
  ProjectModel _project;

  // Constructors
  CategoryModel.empty();
  CategoryModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _name = parseToString(json['name'].toString());
    _projectId = parseToInt(json['project_id'].toString());

    _project = null;
  }
  Future init() async {
    _project = await ProjectRepository().getProjectById(_projectId);
  }

  // Getters
  int get id => _id;
  String get name => _name;
  int get projectId => _projectId;
  ProjectModel get project => _project;
  @override
  String get type => 'category';

  @override
  CategoryModel fromJson(Map<String, dynamic> json) =>
      CategoryModel.fromJson(json);
}
