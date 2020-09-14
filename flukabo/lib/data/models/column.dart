import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/abstract_model.dart';
import 'package:flukabo/data/models/task.dart';
import 'package:flukabo/data/repository/project_repository.dart';

import '../repository/project_repository.dart';
import 'project.dart';

class ColumnModel extends AbstractDataModel {
  int _id;
  String _title;
  int _position;
  int _projectId;
  ProjectModel _project;
  int _taskLimit;
  String _description;

  // Constructors
  ColumnModel.empty();
  ColumnModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _projectId = parseToInt(json['project_id'].toString());
    _position = parseToInt(json['position'].toString());
    _taskLimit = parseToInt(json['task_limit'].toString());
    _title = parseToString(json['title'].toString());
    _description = parseToString(json['description'].toString());
    _project = null;
  }
  Future init() async {
    _project = await ProjectRepository().getProjectById(_projectId);
  }

  // Getters for private fields
  int get id => _id;
  String get title => _title;
  int get position => _position;
  int get projectId => _projectId;
  ProjectModel get project => _project; //! CALL [init] first
  int get taskLimit => _taskLimit;
  String get description => _description;
  @override
  String get type => 'column';

  @override
  ColumnModel fromJson(Map<String, dynamic> json) => ColumnModel.fromJson(json);
}

class ExtendedColumnModel extends ColumnModel {
  List<TaskModel> _tasks;
  int _score;
  int _openTasksCount;
  int _closedTasksCount;
  int _tasksCount;

  // Constructor
  ExtendedColumnModel.empty() : super.empty();
  ExtendedColumnModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    _tasksCount = parseToInt(json['nb_tasks'].toString());
    _openTasksCount = parseToInt(json['nb_open_tasks'].toString());
    _closedTasksCount = parseToInt(json['nb_closed_tasks'].toString());
    _score = parseToInt(json['score'].toString());
    _tasks = parseToList<ExtendedTaskModel>(json['tasks'] as List);
  }

  // Getters
  List<TaskModel> get tasks => _tasks;
  int get tasksCount => _tasksCount;
  int get openTasksCount => _openTasksCount;
  int get closedTasksCount => _closedTasksCount;
  int get score => _score;
  @override
  String get type => 'extended_column';

  @override
  ExtendedColumnModel fromJson(Map<String, dynamic> json) =>
      ExtendedColumnModel.fromJson(json);
}
