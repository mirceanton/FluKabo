import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/kanboard_api_commands.dart';
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
    version = await KanboardAPI()
        .getString(kanboardCommands[ApplicationProcedures.version]);
    timezone = await KanboardAPI()
        .getString(kanboardCommands[ApplicationProcedures.timezone]);
    applicationRoles = await KanboardAPI()
        .getStringMap(kanboardCommands[ApplicationProcedures.applicationRoles]);
    projectRoles = await KanboardAPI()
        .getStringMap(kanboardCommands[ApplicationProcedures.projectRoles]);
    defaultTaskColor = defaultColors[await KanboardAPI()
        .getString(kanboardCommands[ApplicationProcedures.defaultTaskColor])];
  }
}
