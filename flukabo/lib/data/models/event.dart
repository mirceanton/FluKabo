import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/template_model.dart';
import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/repository/project_repository.dart';
import 'package:flukabo/data/repository/user_repository.dart';

class EventModel extends TemplateModel {
  int _id;
  int _taskId;
  int _projectId;
  int _authorId;
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
  }

  // Getters
  int get id => _id;
  int get taskId => _taskId;
  // TODO Future<TaskModel> get task async => TaskRepository().getTaskById(_taskId);
  int get projectId => _projectId;
  Future<ProjectModel> get project async =>
      ProjectRepository().getProjectById(_projectId);
  int get authorId => _authorId;
  Future<UserModel> get author async => UserRepository().getUserById(_authorId);
  double get date => _date;
  String get title => _title;
  @override
  String get type => 'event';

  @override
  EventModel fromJson(Map<String, dynamic> json) => EventModel.fromJson(json);
}
