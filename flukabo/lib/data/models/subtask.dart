import '../../data/helpers/json_parser.dart';
import '../../data/models/abstract_model.dart';
import '../../data/models/task.dart';
import '../../data/models/user.dart';
import '../../data/repository/task_repository.dart';
import '../../data/repository/user_repository.dart';

class SubtaskModel extends AbstractDataModel {
  int _id;
  String _title;
  bool _status;
  int _timeEstimated;
  int _timeSpent;
  int _taskId;
  TaskModel _task;
  int _userId;
  UserModel _user;

  // Constructors
  SubtaskModel.empty();
  SubtaskModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _title = parseToString(json['title'].toString());
    _status = parseToBool(json['status'].toString());
    _timeEstimated = parseToInt(json['time_estimated'].toString());
    _timeSpent = parseToInt(json['time_spent'].toString());
    _taskId = parseToInt(json['task_id'].toString());
    _userId = parseToInt(json['user_id'].toString());

    _task = null;
    _user = null;
  }
  Future init() async {
    _task = await TaskRepository().getTaskById(_taskId);
    _user = await UserRepository().getUserById(_userId);
  }

  // Getters
  int get id => _id;
  String get title => _title;
  bool get status => _status;
  int get timeEstimated => _timeEstimated;
  int get timeSpent => _timeSpent;
  int get taskId => _taskId;
  TaskModel get task => _task;
  int get userId => _userId;
  UserModel get user => _user;
  @override
  String get type => 'subtask';

  @override
  SubtaskModel fromJson(Map<String, dynamic> json) =>
      SubtaskModel.fromJson(json);
}
