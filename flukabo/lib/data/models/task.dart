import 'package:flukabo/data/models/swimlane.dart';
import 'package:flukabo/data/repository/swimlane_repository.dart';
import 'package:flukabo/ui/pages/task/task_details_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../res/kanboard/kanboard_colors.dart';
import '../helpers/json_parser.dart';
import '../repository/column_repository.dart';
import '../repository/project_repository.dart';
import '../repository/user_repository.dart';
import 'abstract_model.dart';
import 'column.dart';
import 'project.dart';
import 'tag.dart';
import 'user.dart';

class TaskModel extends AbstractDataModel {
  int _id;
  String _title;
  String _description;
  String _dateCreation;
  String _colorId;
  int _projectId;
  ProjectModel _project;
  int _columnId;
  ColumnModel _column;
  int _ownerId;
  UserModel _owner;
  int _position;
  bool _isActive;
  String _dateCompleted;
  int _complexity; // the api calls it 'score'
  String _dateDue;
  int _categoryId;
  int _creatorId;
  UserModel _creator;
  String _dateModification;
  String _reference;
  String _dateStarted;
  int _timeSpent;
  int _timeEstimated;
  int _swimlaneId;
  SwimlaneModel _swimlane;
  String _dateMoved;
  int _recurrenceStatus;
  int _recurrenceTrigger;
  int _recurrenceFactor;
  int _recurrenceTimeframe;
  int _recurrenceBasedate;
  int _priority;
  List<TagModel> _tags;

  TaskModel({
    String name = "",
    String description = "",
    int priority = 0,
    int difficulty = 0,
  })  : _title = name,
        _description = description,
        _priority = priority,
        _complexity = difficulty;
  TaskModel.empty();
  TaskModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _title = parseToString(json['title'].toString());
    _description = parseToString(json['description'].toString());
    _dateCreation = parseToString(json['date_creation'].toString());
    _colorId = parseToString(json['color']['name'].toString());
    _projectId = parseToInt(json['project_id'].toString());
    _columnId = parseToInt(json['column_id'].toString());
    _ownerId = parseToInt(json['owner_id'].toString());
    _position = parseToInt(json['position'].toString());
    _isActive = parseToBool(json['is_active'].toString());
    _dateCompleted = parseToString(json['date_completed'].toString());
    _complexity = parseToInt(json['score'].toString());
    _dateDue = parseToString(json['date_due'].toString());
    _categoryId = parseToInt(json['category_id'].toString());
    _creatorId = parseToInt(json['creator_id'].toString());
    _dateModification = parseToString(json['date_modification'].toString());
    _reference = parseToString(json['reference'].toString());
    _dateStarted = parseToString(json['date_started'].toString());
    _timeSpent = parseToInt(json['time_spent'].toString());
    _timeEstimated = parseToInt(json['time_estimated'].toString());
    _swimlaneId = parseToInt(json['swimlane_id'].toString());
    _dateMoved = parseToString(json['date_moved'].toString());
    _recurrenceStatus = parseToInt(json['recurrence_status'].toString());
    _recurrenceTrigger = parseToInt(json['recurrence_trigger'].toString());
    _recurrenceFactor = parseToInt(json['recurrence_factor'].toString());
    _recurrenceTimeframe = parseToInt(json['recurrence_timeframe'].toString());
    _recurrenceBasedate = parseToInt(json['recurrence_basedate'].toString());
    _priority = parseToInt(json['priority'].toString());
    _tags = null;
    _project = null;
    _column = null;
    _owner = null;
    _creator = null;
    _swimlane = null;
  }
  Future init() async {
    _project = await ProjectRepository().getProjectById(_projectId);
    _owner = await UserRepository().getUserById(_ownerId);
    _creator = await UserRepository().getUserById(_creatorId);
    _column = await ColumnRepository().getColumnById(_columnId);
    _swimlane = await SwimlaneRepository().getSwimlaneById(_swimlaneId);
    // TODO _tags = await TagRepository().getTaskTags(_id);
  }

  // Getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get dateCreation => _dateCreation;
  String get colorId => _colorId;
  Color get color => defaultColors[_colorId];
  int get projectId => _projectId;
  ProjectModel get project => _project;
  int get columnId => _columnId;
  ColumnModel get column => _column;
  int get ownerId => _ownerId;
  UserModel get owner => _owner;
  int get position => _position;
  bool get isActive => _isActive;
  String get dateCompleted => _dateCompleted;
  int get complexity => _complexity;
  String get dateDue => _dateDue;
  int get categoryId => _categoryId;
  int get creatorId => _creatorId;
  UserModel get creator => _creator;
  String get dateModification => _dateModification;
  String get reference => _reference;
  String get dateStarted => _dateStarted;
  int get timeSpent => _timeSpent;
  int get timeEstimated => _timeEstimated;
  int get swimlaneId => _swimlaneId;
  SwimlaneModel get swimlane => _swimlane;
  String get dateMoved => _dateMoved;
  int get recurrenceStatus => _recurrenceStatus;
  int get recurrenceTrigger => _recurrenceTrigger;
  int get recurrenceFactor => _recurrenceFactor;
  int get recurrenceTimeframe => _recurrenceTimeframe;
  int get recurrenceBasedate => _recurrenceBasedate;
  int get priority => _priority;
  Color get priorityColor {
    final double threshold =
        (_project.priorityEnd - _project.priorityStart) / 3;
    if (priority < threshold.toInt()) {
      return Colors.green;
    }
    if (priority < 2 * threshold.toInt()) {
      return Colors.yellow;
    }
    return Colors.red;
  }

  List<TagModel> get tags => _tags;
  @override
  String get type => 'task';

  @override
  TaskModel fromJson(Map<String, dynamic> json) => TaskModel.fromJson(json);

  bool hasDescription() => _description.isNotEmpty;

  Set<Future> navigate(BuildContext context) {
    return {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetailsPage(this),
        ),
      )
    };
  }

  Widget buildIcon() => Icon(
        MdiIcons.circle,
        size: 48.0,
        color: priorityColor,
      );
  Widget buildTitle() {
    return Hero(
      tag: "${_title}_title",
      child: Material(
        color: Colors.transparent,
        child: Text(
          _title,
          style: const TextStyle(
            fontSize: 16,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
