import 'package:flukabo/data/models/abstract_model.dart';
import 'package:flukabo/data/repository/task_repository.dart';

import '../helpers/json_parser.dart';
import '../repository/user_repository.dart';
import 'task.dart';
import 'user.dart';

class CommentModel extends AbstractDataModel {
  int _id;
  int _taskId;
  TaskModel _task;
  int _userId;
  UserModel _user;
  String _dateCreation;
  String _content;

  // Constructors
  CommentModel.empty();
  CommentModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _taskId = parseToInt(json['task_id'].toString());
    _userId = parseToInt(json['user_id'].toString());
    _dateCreation = parseToString(json['date_creation'].toString());
    _content = parseToString(json['comment'].toString());
    _user = null;
    _task = null;
  }
  Future init() async {
    _user = await UserRepository().getUserById(_userId);
    _task = await TaskRepository().getTaskById(_taskId);
  }

  int get id => _id;
  int get taskId => _taskId;
  TaskModel get task => _task;
  int get userId => _userId;
  UserModel get user => _user;
  String get dateCreation => _dateCreation;
  String get content => _content;
  @override
  String get type => 'comment';

  @override
  CommentModel fromJson(Map<String, dynamic> json) =>
      CommentModel.fromJson(json);
}
