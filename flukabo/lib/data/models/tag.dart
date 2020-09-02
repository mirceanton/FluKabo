import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/repository/project_repository.dart';

class TagModel {
  int _id;
  int _projectId;
  String _name;

  TagModel.empty();
  TagModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _projectId = parseToInt(json['project_id'].toString());
    _name = parseToString(json['name'].toString());
  }

  // Getters
  int get id => _id;
  int get projectId => _projectId;
  Future<ProjectModel> get project =>
      ProjectRepository().getProjectById(_projectId);
  String get name => _name;
}
