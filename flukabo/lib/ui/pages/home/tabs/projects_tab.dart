import 'package:flukabo/ui/templates/project/project_list_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../bloc/data/projects/projects_bloc.dart';

import 'abstract_tab_class.dart';

class FakeTabBar extends StatelessWidget {
  final TabController controller;
  const FakeTabBar({this.controller});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: 48,
        ),
        TabBar(
          controller: controller,
          tabs: const [
            Tab(text: 'Personal'),
            Tab(text: 'Public'),
          ],
        ),
      ],
    );
  }
}

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

  @override
  Widget buildContent() {
    return BlocProvider(
      create: (context) => ProjectsBloc(),
      child: Column(
        children: [
          FakeTabBar(controller: _tabController),
          const ProjectTileListBlocConsumer(),
        ],
      ),
    );
  }
}
