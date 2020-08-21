import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/kanboard_api_commands.dart';
import 'package:flukabo/res/kanboard/kanboard_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KanboardRepository {
  static final KanboardRepository _instance = KanboardRepository._constructor();
  String version, timezone;
  Color defaultTaskColor;
  Map<String, String> applicationRoles, projectRoles;

  factory KanboardRepository() => _instance;

  KanboardRepository._constructor();

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
