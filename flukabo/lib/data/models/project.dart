import 'dart:convert';

import 'package:flukabo/ui/pages/project/project_board_page.dart';
import 'package:flutter/material.dart';

class ProjectModel {
  int _id;
  String _name;
  String _backgroundImage;
  bool _isPrivate;
  bool _isActive;
  String _token;
  double _lastModified;
  bool _isPublic;
  bool _everybodyAllowed;
  String _defaultSwimlane;
  bool _showDefaultSwimlane;
  String _description;
  String _identifier;
  double _startDate, _endDate;
  int _ownerID;
  int _priorityStart, _priorityEnd, _priorityDefault;
  String _email;
  String _predefinedEmailSubjects;
  bool _swimlaneTaskLimit;
  int _taskLimit;
  bool _enableGlobalTags;
  Map<String, String> _url;

  ProjectModel({
    int id,
    String name,
    String description,
    String backgroundImage = "https://source.unsplash.com/random",
    bool isPrivate,
  })  : _id = id,
        _name = name,
        _description = description,
        _backgroundImage = backgroundImage,
        _isPrivate = isPrivate;

  ProjectModel.empty();
  ProjectModel.fromJson(Map<String, String> json)
      : _id = int.parse(json['id']),
        _name = json['name'],
        _backgroundImage = "https://source.unsplash.com/random",
        _isActive = json['is_active'] == '1',
        _token = json['token'],
        _lastModified = double.parse(json['last_modified']),
        _isPublic = json['is_public'] == '1',
        _isPrivate = json['is_private'] == '1',
        _everybodyAllowed = json['is_everybody_allowed'] == '1',
        _defaultSwimlane = json['default_swimlane'],
        _showDefaultSwimlane = json['show_default_swimlane'] == '1',
        _description = json['description'],
        _identifier = json['identifier'],
        _startDate = double.parse(json['start_date']),
        _endDate = double.parse(json['end_date']),
        _ownerID = int.parse(json['owner_id']),
        _priorityStart = int.parse(json['priority_start']),
        _priorityEnd = int.parse(json['priority_end']),
        _priorityDefault = int.parse(json['priority_default']),
        _email = json['email'],
        _predefinedEmailSubjects = json['predefined_email_subjects'],
        _swimlaneTaskLimit = json['per_swimlane_task_limits'] == '1',
        _taskLimit = int.parse(json['task_limit']),
        _enableGlobalTags = json['enable_global_tags'] == '1',
        _url = Map.from(jsonDecode(json['url']) as Map<String, dynamic>);

  // Getters for private fields
  int get id => _id;
  String get name => _name;
  String get backgroundImage => _backgroundImage;
  bool get isPrivate => _isPrivate;
  IconData get privacyIcon => _isPrivate ? Icons.lock : null;
  bool get isActive => _isActive;
  String get token => _token;
  double get lastModified => _lastModified;
  bool get isPublic => _isPublic;
  IconData get publicIcon => _isPublic ? Icons.group : null; // FIXME
  bool get everybodyAllowed => _everybodyAllowed;
  String get defaultSwimlane => _defaultSwimlane;
  bool get showDefaultSwimlane => _showDefaultSwimlane;
  String get description => _description;
  String get identifier => _identifier;
  double get startDate => _startDate;
  double get endDate => _endDate;
  int get ownerID => _ownerID;
  int get priorityStart => _priorityStart;
  int get priorityEnd => _priorityEnd;
  int get priorityDefault => _priorityDefault;
  String get email => _email;
  String get predefinedEmailSubjects => _predefinedEmailSubjects;
  bool get swimlaneTaskLimit => _swimlaneTaskLimit;
  int get taskLimit => _taskLimit;
  bool get enableGlobalTags => _enableGlobalTags;
  Map<String, String> get url => _url;

  ///
  /// [navigate] creates a MaterialNavigationRoute to the board page and passes
  /// the current project as the parameter, and then navigates to the newly
  /// created page
  ///
  Set<Future> navigate(BuildContext context) {
    return {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectBoardPage(this),
        ),
      )
    };
  }

  // Widget Generating methods
  Widget buildBgImage({@required double width, @required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Hero(
        tag: "${_name}_img",
        child: Image.network(
          _backgroundImage,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Hero(
      tag: "${_name}_title",
      child: Material(
        color: Colors.transparent,
        child: Text(
          _name,
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1.1,
            color: Theme.of(context).primaryTextTheme.bodyText1.color,
          ),
        ),
      ),
    );
  }
}
