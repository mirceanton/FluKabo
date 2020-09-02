import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/repository/project_repository.dart';

class TagModel {
  int _id;
  int _projectId;
  String _name;

  TagModel.empty();
  TagModel.fromJson(Map<String, dynamic> json) {
    _id = _parseToInt(json['id'].toString());
    _projectId = _parseToInt(json['project_id'].toString());
    _name = _parseToString(json['name'].toString());
  }

  String _parseToString(String json) => json == 'null' ? '' : json;

  int _parseToInt(String json) {
    if (json.isEmpty) return 0;
    try {
      return int.parse(json);
    } catch (_) {
      return 0;
    }
  }

  // Getters
  int get id => _id;
  int get projectId => _projectId;
  Future<ProjectModel> get project =>
      ProjectRepository().getProjectById(_projectId);
  String get name => _name;
}
