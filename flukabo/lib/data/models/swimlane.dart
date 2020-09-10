import 'package:flukabo/data/models/abstract_model.dart';

import '../helpers/json_parser.dart';
import '../repository/project_repository.dart';
import '../singletons/kanboard_api_client.dart';
import 'project.dart';

class SwimlaneModel extends AbstractDataModel {
  int _id;
  String _name;
  int _position;
  bool _isActive;
  int _projectId;
  ProjectModel _project;

  // Constructors
  SwimlaneModel.empty();
  SwimlaneModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _name = parseToString(json['name'].toString());
    _position = parseToInt(json['position'].toString());
    _isActive = parseToBool(json['is_active'].toString());
    _projectId = parseToInt(json['project_id'].toString());
    _project = null;
  }
  Future init() async {
    _project = await ProjectRepository().getProjectById(_projectId);
  }

  // Getters
  int get id => _id;
  String get name => _name;
  int get position => _position;
  bool get isActive => _isActive;
  int get projectId => _projectId;
  ProjectModel get project => _project;
  @override
  String get type => 'swimlane';

  @override
  SwimlaneModel fromJson(Map<String, dynamic> json) =>
      SwimlaneModel.fromJson(json);
}
