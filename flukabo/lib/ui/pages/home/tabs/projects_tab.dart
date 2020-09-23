import 'package:flukabo/bloc/data/projects/events/events.dart';
import 'package:flukabo/bloc/data/projects/projects_bloc.dart';
import 'package:flukabo/bloc/data/projects/states/states.dart';
import 'package:flukabo/data/models/project.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ui/templates/project/project_list_view.dart';
import '../../../commons.dart';
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

  Widget _builder(BuildContext context, ProjectsState state) {
    if (state is LoadingState) {
      return buildLoadingIndicator();
    } else if (state is ErrorState) {
      return buildConnectionErrorIndicator(context);
    } else if (state is SuccessState) {
      if (state is ProjectListFetchedState) {
        return TabBarView(
          controller: _tabController,
          children: [
            _buildProjectListView(
              state.projects.where((element) => element.isPrivate).toList(),
            ),
            _buildProjectListView(
              state.projects.where((element) => !element.isPrivate).toList(),
            ),
          ],
        );
      }
    }
    // if the state is InitState, attempt a Fetch Event
    context.bloc<ProjectsBloc>().add(const FetchAllEvent());
    return buildInitPage();
  }

  void _listener(BuildContext context, ProjectsState state) {
    if (state is ErrorState) {
      showSnackbar(
        context: context,
        content: state.errmsg,
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
              listener: _listener,
              builder: _builder,
            ),
          )
        ],
      ),
    );
  }
}
