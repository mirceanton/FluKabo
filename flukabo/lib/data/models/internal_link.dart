import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/abstract_model.dart';
import 'package:flukabo/data/models/link.dart';
import 'package:flukabo/data/models/task.dart';
import 'package:flukabo/data/repository/link_repository.dart';
import 'package:flukabo/data/repository/task_repository.dart';

class InternalLinkModel extends AbstractDataModel {
  int _taskId;
  TaskModel _task;
  int _oppositeTaskId;
  TaskModel _oppositeTask;
  int _linkId;
  LinkModel _link;

  // Constructor
  InternalLinkModel.empty();
  InternalLinkModel.fromJson(Map<String, dynamic> json) {
    _taskId = parseToInt(json['task_id'].toString());
    _oppositeTaskId = parseToInt(json['opposite_task_id'].toString());
    _linkId = parseToInt(json['link_id'].toString());

    _link = null;
    _task = null;
    _oppositeTask = null;
  }
  Future init() async {
    _link = await LinkRepository().getLinkById(_linkId);
    _task = await TaskRepository().getTaskById(_taskId);
    _oppositeTask = await TaskRepository().getTaskById(_oppositeTaskId);
  }

  // Getters
  int get taskId => _taskId;
  TaskModel get task => _task;
  int get oppositeTaskId => _oppositeTaskId;
  TaskModel get oppositeTask => _oppositeTask;
  int get linkId => _linkId;
  LinkModel get link => _link;
  @override
  String get type => 'internal_link';

  @override
  InternalLinkModel fromJson(Map<String, dynamic> json) =>
      InternalLinkModel.fromJson(json);
}
