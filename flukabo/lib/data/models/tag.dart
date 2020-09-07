import 'dart:ui';

import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/template_model.dart';
import 'package:flukabo/data/repository/project_repository.dart';
import 'package:flukabo/res/kanboard/kanboard_colors.dart';

class TagModel extends TemplateModel {
  int _id;
  int _projectId;
  String _name;
  String _colorId;

  // Constructors
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
  @override
  String get type => 'tag';

  @override
  TagModel fromJson(Map<String, dynamic> json) => TagModel.fromJson(json);
}
