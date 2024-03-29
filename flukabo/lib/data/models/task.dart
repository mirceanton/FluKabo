import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../data/models/category.dart';
import '../../data/models/swimlane.dart';
import '../../data/repository/tag_repository.dart';
import '../../res/kanboard/kanboard_colors.dart';
import '../../ui/pages/task/task_details_page.dart';
import '../../ui/templates/task/task_commons.dart';
import '../helpers/json_parser.dart';
import '../repository/user_repository.dart';
import 'abstract_model.dart';
import 'column.dart';
import 'project.dart';
import 'tag.dart';
import 'user.dart';

class TaskModel extends AbstractDataModel {
  int id;
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
  CategoryModel _category;
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

  // Constructors
  TaskModel.empty();
  TaskModel.fromJson(Map<String, dynamic> json) {
    id = parseToInt(json['id'].toString());
    _title = parseToString(json['title'].toString());
    _description = parseToString(json['description'].toString());
    _dateCreation = parseToString(json['date_creation'].toString());
    if (json['color'] == null) {
      _colorId = parseToString(json['color_id'].toString());
    } else {
      _colorId = parseToString(json['color']['name'].toString());
    }
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

    if (json['tags'] == null) {
      _tags = null;
    } else {
      _tags = parseToList<TagModel>(json['tags'] as List);
    }
    _project = null;
    _column = null;
    _owner = null;
    _creator = null;
    _swimlane = null;
    _category = null;
  }
  Future init() async {
    //FIXME
    // _project = await ProjectRepository().getProjectById(_projectId);
    _owner =
        _ownerId != 0 ? await UserRepository().getUserById(_ownerId) : null;
    // _creator = await UserRepository().getUserById(_creatorId);
    // _column = await ColumnRepository().getColumnById(_columnId);
    // _swimlane = await SwimlaneRepository().getSwimlaneById(_swimlaneId);
    // if (_categoryId > 0) {
    //   _category = await CategoryRepository().getCategoryById(_categoryId);
    // }
    _tags = await TagRepository().getTaskTags(id);
  }

  // Getters
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
  CategoryModel get category => _category;
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

  List<TagModel> get tags => _tags;
  List<String> get tagNames {
    final List<String> names = [];
    for (int i = 0; i < _tags.length; i++) {
      names.add(_tags[i].name);
    }
    return names;
  }

  List<Widget> get modifierIcons {
    final List<Widget> icons = [];
    if (_description != null && _description.isNotEmpty) {
      icons.add(Icon(
        MdiIcons.text,
        size: 12,
        color: Colors.blueGrey[200],
      ));
      icons.add(ModifierIconsDivider());
    }
    icons.add(TextIcon('P$priority'));
    icons.add(ModifierIconsDivider());
    icons.add(TextIcon('C$complexity'));

    return icons;
  }

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
}

class ExtendedTaskModel extends TaskModel {
  int _commentsCount;
  int _filesCount;
  int _subtasksCount;
  int _linksCount;
  int _completedSubtasksCount;
  String _assigneeUsername;
  UserModel _assignee;

  // Constructors
  ExtendedTaskModel.empty() : super.empty();
  ExtendedTaskModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    _commentsCount = parseToInt(json['nb_comments'].toString());
    _subtasksCount = parseToInt(json['nb_subtasks'].toString());
    _linksCount = parseToInt(json['nb_links'].toString());
    _completedSubtasksCount =
        parseToInt(json['nb_completed_subtasks'].toString());
    _filesCount = parseToInt(json['nb_files'].toString());
    _assigneeUsername = parseToString(json['assignee_username'].toString());

    _assignee = null;
  }
  @override
  Future init() async {
    await super.init();
    if (_assigneeUsername == null || _assigneeUsername.isEmpty) {
      _assignee = null;
    } else {
      _assignee = await UserRepository().getUserByUsername(_assigneeUsername);
    }
  }

  // Getters
  int get commentsCount => _commentsCount;
  int get filesCount => _filesCount;
  int get subtasksCount => _subtasksCount;
  int get linksCount => _linksCount;
  int get completedSubtasksCount => _completedSubtasksCount;
  String get assigneeUsername => _assigneeUsername;
  UserModel get assignee => _assignee;
  @override
  String get type => 'extended_task';

  @override
  ExtendedTaskModel fromJson(Map<String, dynamic> json) =>
      ExtendedTaskModel.fromJson(json);
}
