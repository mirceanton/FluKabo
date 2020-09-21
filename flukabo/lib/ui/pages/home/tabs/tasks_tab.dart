import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'abstract_tab_class.dart';

class TasksTab extends HomeTab {
  TasksTab();

  @override
  String get name => 'Tasks';
  @override
  IconData get icon => MdiIcons.checkBold;

  @override
  HomeTabState createState() => _TasksTabState();
}

class _TasksTabState extends HomeTabState {}
