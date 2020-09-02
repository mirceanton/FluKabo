import 'dart:convert';

import 'package:flukabo/ui/pages/project/project_board_page.dart';
import 'package:flutter/material.dart';

class ProjectModel {
  int _id;
  String _name;
  String _backgroundImage;
  bool _isActive;
  String _token;
  double _lastModified;
  bool _isPublic;
  bool _isPrivate;
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
  ProjectModel.fromJson(Map<String, dynamic> json) {
    _id = _parseToInt(json['id'].toString());
    _name = _parseToString(json['name'].toString());
    _backgroundImage = "https://source.unsplash.com/random"; // FIXME
    _isActive = _parseToBool(json['is_active'].toString());
    _token = _parseToString(json['token'].toString());
    _lastModified = _parseToDouble(json['last_modified'].toString());
    _isPublic = _parseToBool(json['is_public'].toString());
    _isPrivate = _parseToBool(json['is_private'].toString());
    _description = _parseToString(json['description'].toString());
    _identifier = _parseToString(json['identifier'].toString());
    _startDate = _parseToDouble(json['start_date'].toString());
    _endDate = _parseToDouble(json['end_date'].toString());
    _ownerID = _parseToInt(json['owner_id'].toString());
    _priorityStart = _parseToInt(json['priority_start'].toString());
    _priorityEnd = _parseToInt(json['priority_end'].toString());
    _priorityDefault = _parseToInt(json['priority_default'].toString());
    _email = _parseToString(json['email'].toString());
    _predefinedEmailSubjects =
        _parseToString(json['predefined_email_subjects'].toString());
    _swimlaneTaskLimit =
        _parseToBool(json['per_swimlane_task_limits'].toString());
    _taskLimit = _parseToInt(json['task_limit'].toString());
    _enableGlobalTags = _parseToBool(json['enable_global_tags'].toString());
    _url = Map<String, String>.from(json['url'] as Map<String, dynamic>);
  }

  // Helper functions
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

  bool _parseToBool(String json) =>
      json.isNotEmpty && (json == '1' || json == 'true');

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
