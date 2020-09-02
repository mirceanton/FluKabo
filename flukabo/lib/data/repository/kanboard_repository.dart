import 'dart:convert';

import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/application_procedures.dart';
import 'package:flukabo/res/kanboard/kanboard_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the data associated with the
/// app running on the server, such as:
/// - app version
/// - active timezone
/// - application and project roles which are app-wide
/// - the default color given to a task
/// - a list of all of the available task colors
///
class KanboardRepository {
  static final KanboardRepository _instance = KanboardRepository._constructor();
  String version, timezone;
  Color defaultTaskColor;
  Map<String, String> applicationRoles, projectRoles;

  factory KanboardRepository() => _instance;
  KanboardRepository._constructor(); // empty constructor

  /// [init] fetches and caches all the fields
  Future<void> init() async {
    version =
        await _parseString(kanboardCommands[ApplicationProcedures.version]);
    timezone =
        await _parseString(kanboardCommands[ApplicationProcedures.timezone]);
    applicationRoles = await _parseMap(
        kanboardCommands[ApplicationProcedures.applicationRoles]);
    projectRoles =
        await _parseMap(kanboardCommands[ApplicationProcedures.projectRoles]);
    defaultTaskColor = defaultColors[await _parseString(
        kanboardCommands[ApplicationProcedures.defaultTaskColor])];
  }

  ///
  /// [_parseString] returns a single string parsed from the json output of the
  /// given command
  ///
  Future<String> _parseString(String command) async {
    final String json = await KanboardAPI().getJson(
      command: command,
      params: {},
    );
    return jsonDecode(json)['result'].toString();
  }

  ///
  /// [_parseMap] returns a Map of strings parsed from the json output of the
  /// given command
  ///
  Future<Map<String, String>> _parseMap(String command) async {
    final String json = await KanboardAPI().getJson(
      command: command,
      params: {},
    );
    return Map.from(jsonDecode(json)['result'] as Map<String, dynamic>);
  }

  // todo DELETEME
  void display() {
    print('Version: $version');
    print('Timezone: $timezone');
    print('Default Task Color: $defaultTaskColor');
    print('Application roles: $applicationRoles');
    print('Project roles: $projectRoles');
  }
}
