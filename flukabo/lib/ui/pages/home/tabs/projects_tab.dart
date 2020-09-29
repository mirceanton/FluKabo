import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../bloc/data/projects/events/events.dart';
import '../../../../bloc/data/projects/functions.dart';
import '../../../../bloc/data/projects/projects_bloc.dart';

import '../../../../data/models/project.dart';

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

class _ProjectsTabState extends HomeTabState with TickerProviderStateMixin {
  TabController _tabController;
  _ProjectsTabState() {
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildProjectListView(List<ProjectModel> projects) {
    if (projects.isEmpty) {
      return const Center(child: Text('No projects to show'));
    } else {
      return ProjectListView(
        height: double.infinity,
        width: double.infinity,
        projects: projects,
        showCards: false,
      );
    }
  }

  @override
  Widget buildContent() {
    return BlocProvider(
      create: (context) => ProjectsBloc(),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: 48,
              ),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Personal'),
                  Tab(text: 'Public'),
                ],
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<ProjectsBloc, ProjectsState>(
              listener: listener,
              builder: (context, state) => builder(
                context,
                state,
                defaultEvent: const FetchAllEvent(),
                // showCards: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
