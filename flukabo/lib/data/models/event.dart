import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/abstract_model.dart';
import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/repository/project_repository.dart';
import 'package:flukabo/data/repository/task_repository.dart';
import 'package:flukabo/data/repository/user_repository.dart';

import '../repository/project_repository.dart';
import '../repository/user_repository.dart';
import 'project.dart';
import 'task.dart';
import 'user.dart';

class EventModel extends AbstractDataModel {
  int _id;
  int _taskId;
  TaskModel _task;
  int _projectId;
  ProjectModel _project;
  int _authorId;
  UserModel _author;
  double _date;
  String _title;

  // Constructors
  EventModel.empty();
  EventModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _taskId = parseToInt(json['task_id'].toString());
    _projectId = parseToInt(json['project_id'].toString());
    _authorId = parseToInt(json['creator_id'].toString());
    _date = parseToDouble(json['date_creation'].toString());
    _title = parseToString(json['event_title'].toString());
    _task = null;
    _project = null;
    _author = null;
  }
  Future init() async {
    _project = await ProjectRepository().getProjectById(_projectId);
    _task = await TaskRepository().getTaskById(_taskId);
    _author = await UserRepository().getUserById(_authorId);
  }

  // Getters
  int get id => _id;
  int get taskId => _taskId;
  TaskModel get task => _task;
  int get projectId => _projectId;
  ProjectModel get project => _project;
  int get authorId => _authorId;
  UserModel get author => _author;
  double get date => _date;
  String get title => _title;
  @override
  String get type => 'event';

  @override
  EventModel fromJson(Map<String, dynamic> json) => EventModel.fromJson(json);
}
