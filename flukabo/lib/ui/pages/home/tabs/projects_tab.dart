import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../bloc/data/projects/events/events.dart';
import '../../../../bloc/data/projects/projects_bloc.dart';

import '../../../../ui/templates/project/project_list_consumer.dart';
import 'abstract_tab_class.dart';

class FakeTabBar extends StatelessWidget {
  final TabController controller;
  final List<Tab> tabs;
  const FakeTabBar({
    @required this.controller,
    @required this.tabs,
  });
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
    return Column(
      children: [
        FakeTabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Personal'), Tab(text: 'Public')],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              BlocProvider(
                create: (context) => ProjectsBloc(),
                child:
                    const ProjectTileListBlocConsumer(FetchPersonalProjects()),
              ),
              BlocProvider(
                create: (context) => ProjectsBloc(),
                child: const ProjectTileListBlocConsumer(FetchPublicProjects()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
