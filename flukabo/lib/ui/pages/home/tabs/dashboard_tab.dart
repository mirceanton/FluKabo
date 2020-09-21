import 'package:flutter/material.dart';
import '../../../../data/models/project.dart';
import '../../../../data/models/task.dart';
import '../../../../ui/templates/project/project_list_view.dart';
import '../../../../ui/templates/task/task_list_view.dart';

import 'abstract_tab_class.dart';

class DashboardTab extends HomeTab {
  DashboardTab(); // empty constructor

  @override
  String get name => 'Dashboard';
  @override
  IconData get icon => Icons.dashboard;

  @override
  HomeTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends HomeTabState {}
