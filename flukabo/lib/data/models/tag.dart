import 'dart:ui';

import '../../data/helpers/json_parser.dart';
import '../../data/models/abstract_model.dart';
import '../../data/models/project.dart';
import '../../data/repository/project_repository.dart';
import '../../res/kanboard/kanboard_colors.dart';
import '../repository/project_repository.dart';
import 'project.dart';

class TagModel extends AbstractDataModel {
  int _id;
  int _projectId;
  ProjectModel _project;
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
  Future init() async {
    _project = await ProjectRepository().getProjectById(_projectId);
  }

  // Getters
  int get id => _id;
  int get projectId => _projectId;
  ProjectModel get project => _project;
  String get name => _name;
  String get colorId => _colorId;
  Color get color => defaultColors[_colorId];
  @override
  String get type => 'tag';

  @override
  TagModel fromJson(Map<String, dynamic> json) => TagModel.fromJson(json);
}
