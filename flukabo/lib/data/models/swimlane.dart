import '../../data/models/abstract_model.dart';
import '../../data/models/column.dart';

import '../helpers/json_parser.dart';
import '../repository/project_repository.dart';
import 'project.dart';

class SwimlaneModel extends AbstractDataModel {
  int _id;
  String _name;
  int _position;
  bool _isActive;
  int _projectId;
  ProjectModel _project;
  String _description;
  int _taskLimit;

  // Constructors
  SwimlaneModel.empty();
  SwimlaneModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _name = parseToString(json['name'].toString());
    _position = parseToInt(json['position'].toString());
    _isActive = parseToBool(json['is_active'].toString());
    _projectId = parseToInt(json['project_id'].toString());
    _description = parseToString(json['description'].toString());
    _taskLimit = parseToInt(json['task_limit'].toString());
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
  String get description => _description;
  int get taskLimit => _taskLimit;
  @override
  String get type => 'swimlane';

  @override
  SwimlaneModel fromJson(Map<String, dynamic> json) =>
      SwimlaneModel.fromJson(json);
}

class ExtendedSwimlaneModel extends SwimlaneModel {
  List<ExtendedColumnModel> _columns;
  int _columnsCount;
  int _tasksCount;
  int _score;

  // Constructors
  ExtendedSwimlaneModel.empty() : super.empty();
  ExtendedSwimlaneModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    _columnsCount = parseToInt(json['nb_columns'].toString());
    _tasksCount = parseToInt(json['nb_tasks'].toString());
    _score = parseToInt(json['score'].toString());
    _columns = parseToList<ExtendedColumnModel>(json['columns'] as List);
  }

  // Getters
  List<ExtendedColumnModel> get columns => _columns;
  int get columnsCount => _columnsCount;
  int get tasksCount => _tasksCount;
  int get score => _score;
  @override
  String get type => 'extended_swimlane';

  @override
  ExtendedSwimlaneModel fromJson(Map<String, dynamic> json) =>
      ExtendedSwimlaneModel.fromJson(json);
}
