import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/repository/project_repository.dart';

class ColumnModel {
  int _id;
  String _title;
  int _position;
  int _projectId;
  int _taskLimit;

  ColumnModel({
    int id,
    String title,
    int position,
    int projectId,
    int taskLimit,
  })  : _id = id,
        _title = title,
        _position = position,
        _projectId = projectId,
        _taskLimit = taskLimit;
  ColumnModel.empty();
  ColumnModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _projectId = parseToInt(json['project_id'].toString());
    _position = parseToInt(json['position'].toString());
    _taskLimit = parseToInt(json['task_limit'].toString());
    _title = parseToString(json['title'].toString());
  }

  // Getters for private fields
  int get id => _id;
  String get title => _title;
  int get position => _position;
  int get projectId => _projectId;
  Future<ProjectModel> get project async =>
      ProjectRepository().getProjectById(_projectId);
  int get taskLimit => _taskLimit;
}
