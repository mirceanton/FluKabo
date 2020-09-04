import 'dart:ui';

import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/repository/project_repository.dart';
import 'package:flukabo/res/kanboard/kanboard_colors.dart';

class TagModel {
  int _id;
  int _projectId;
  String _name;
  String _colorId;

  TagModel({int id, String name, int projectId, String colorId})
      : _id = id,
        _projectId = projectId,
        _name = name,
        _colorId = colorId;
  TagModel.empty();
  TagModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _projectId = parseToInt(json['project_id'].toString());
    _name = parseToString(json['name'].toString());
    _colorId = parseToString(json['color_id'].toString());
  }

  // Getters
  int get id => _id;
  int get projectId => _projectId;
  Future<ProjectModel> get project =>
      ProjectRepository().getProjectById(_projectId);
  String get name => _name;
  String get colorId => _colorId;
  Color get color => defaultColors[_colorId];
}
