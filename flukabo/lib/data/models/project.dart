import 'dart:math';

import 'package:flukabo/data/models/models.dart';
import 'package:flutter/material.dart';
import '../../data/helpers/json_parser.dart';
import '../../data/models/abstract_model.dart';
import '../../ui/pages/project/project_board_page.dart';
import '../repository/user_repository.dart';
import 'user.dart';

class ProjectModel extends AbstractDataModel {
  int id;
  String _name;
  String _backgroundImage;
  bool _isActive;
  String _token;
  double _lastModified;
  bool _isPublic;
  bool _isPrivate;

  /// [_isStarred] is a proprietary value to this app, implemented via metadata
  bool _isStarred;
  String _description;
  String _identifier;
  double _startDate, _endDate;
  int _ownerID;
  UserModel _owner;
  int _priorityStart, _priorityEnd, _priorityDefault;
  String _email;
  String _predefinedEmailSubjects;
  bool _swimlaneTaskLimit;
  int _taskLimit;
  bool _enableGlobalTags;
  Map<String, String> _url;

  // Constructors
  ProjectModel.empty();
  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = parseToInt(json['id'].toString());
    _name = parseToString(json['name'].toString());
    _isActive = parseToBool(json['is_active'].toString());
    _token = parseToString(json['token'].toString());
    _lastModified = parseToDouble(json['last_modified'].toString());
    _isPublic = parseToBool(json['is_public'].toString());
    _isPrivate = parseToBool(json['is_private'].toString());
    _description = parseToString(json['description'].toString());
    _identifier = parseToString(json['identifier'].toString());
    _startDate = parseToDouble(json['start_date'].toString());
    _endDate = parseToDouble(json['end_date'].toString());
    _ownerID = parseToInt(json['owner_id'].toString());
    _priorityStart = parseToInt(json['priority_start'].toString());
    _priorityEnd = parseToInt(json['priority_end'].toString());
    _priorityDefault = parseToInt(json['priority_default'].toString());
    _email = parseToString(json['email'].toString());
    _predefinedEmailSubjects =
        parseToString(json['predefined_email_subjects'].toString());
    _swimlaneTaskLimit =
        parseToBool(json['per_swimlane_task_limits'].toString());
    _taskLimit = parseToInt(json['task_limit'].toString());
    _enableGlobalTags = parseToBool(json['enable_global_tags'].toString());
    _url = Map<String, String>.from(json['url'] as Map<String, dynamic>);
  }

  Future init() async {
    _owner = await UserRepository().getUserById(_ownerID);
    if (_backgroundImage == null || _isStarred == null) await fetchMetadata();
  }

  // Getters for private fields
  String get name => _name;
  String get backgroundImage => _backgroundImage ?? '';
  bool get isPrivate => _isPrivate;
  IconData get privacyIcon => _isPrivate ? Icons.lock_outline : Icons.lock_open;
  bool get isActive => _isActive;
  String get token => _token;
  double get lastModified => _lastModified;
  bool get isPublic => _isPublic;
  IconData get publicIcon => _isPublic ? Icons.group : Icons.person;
  bool get isStarred => _isStarred ?? false;
  String get description => _description;
  String get identifier => _identifier;
  double get startDate => _startDate;
  double get endDate => _endDate;
  int get ownerID => _ownerID;
  UserModel get owner => _owner;
  int get priorityStart => _priorityStart;
  int get priorityEnd => _priorityEnd;
  int get priorityDefault => _priorityDefault;
  String get email => _email;
  String get predefinedEmailSubjects => _predefinedEmailSubjects;
  bool get swimlaneTaskLimit => _swimlaneTaskLimit;
  int get taskLimit => _taskLimit;
  bool get enableGlobalTags => _enableGlobalTags;
  Map<String, String> get url => _url;
  @override
  String get type => 'project';

  @override
  ProjectModel fromJson(Map<String, dynamic> json) =>
      ProjectModel.fromJson(json);

  ///
  /// [fetchMetadata] makes an api call to retrieve the metadata fields
  /// containing the link to the background image and cache it into
  /// [_backgroundImage] and whether or not the project should appear into the
  /// dashboard tab and cache it into [_isStarred]
  ///
  Future fetchMetadata() async {
    // _backgroundImage = await ProjectRepository()
    //     .getProjectMetadataByKey(projectId: id, key: 'bgImage');
    // _isStarred = await ProjectRepository()
    //     .getProjectMetadataByKey(projectId: id, key: 'isStarred');

    //TODO deleteme
    _backgroundImage = 'https://source.unsplash.com/random';
    _isStarred = Random().nextBool();
  }

  ///
  /// [navigate] creates a MaterialNavigationRoute to the board page and passes
  /// the current project as the parameter, and then navigates to the newly
  /// created page
  ///
  Set<Future> navigate(BuildContext context) {
    return {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProjectBoardPage(this)),
      )
    };
  }
}
