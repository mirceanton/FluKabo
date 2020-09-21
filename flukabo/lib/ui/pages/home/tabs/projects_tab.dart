import 'package:flukabo/bloc/data/projects/states/loading_state.dart';
import 'package:flukabo/bloc/data/projects/states/states.dart';
import 'package:flukabo/data/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flukabo/bloc/data/projects/events/events.dart';
import 'package:flukabo/bloc/data/projects/projects_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../../../../ui/templates/project/project_list_view.dart';
import 'abstract_tab_class.dart';

class ProjectsTab extends HomeTab {
  // Constructor
  ProjectsTab();

  @override
  String get name => 'Projects';
  @override
  IconData get icon => MdiIcons.bulletinBoard;

  @override
  HomeTabState createState() => _ProjectsTabState();
}

class _ProjectsTabState extends HomeTabState {}
