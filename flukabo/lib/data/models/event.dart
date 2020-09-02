import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/data/models/user.dart';
import 'package:flukabo/data/repository/project_repository.dart';
import 'package:flukabo/data/repository/user_repository.dart';

class EventModel {
  int _id;
  int _taskId;
  int _projectId;
  int _authorId;
  double _date;
  String _title;

  EventModel.empty();
  EventModel.fromJson(Map<String, dynamic> json) {
    _id = _parseToInt(json['id'].toString());
    _taskId = _parseToInt(json['task_id'].toString());
    _projectId = _parseToInt(json['project_id'].toString());
    _authorId = _parseToInt(json['creator_id'].toString());
    _date = _parseToDouble(json['date_creation'].toString());
    _title = _parseToString(json['event_title'].toString());
  }

  String _parseToString(String json) => json == 'null' ? '' : json;
  double _parseToDouble(String json) {
    if (json.isEmpty) return 0.0;
    try {
      return double.parse(json);
    } catch (_) {
      return 0.0;
    }
  }

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
  int get taskId => _taskId;
  // TODO Future<TaskModel> get task async => TaskRepository().getTaskById(_taskId);
  int get projectId => _projectId;
  Future<ProjectModel> get project async =>
      ProjectRepository().getProjectById(_projectId);
  int get authorId => _authorId;
  Future<UserModel> get author async => UserRepository().getUserById(_authorId);
  double get date => _date;
  String get title => _title;
}
