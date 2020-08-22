import 'package:flukabo/data/models/project.dart';
import 'package:flutter/material.dart';

// FIXME

class ProjectBoardPage extends StatefulWidget {
  final ProjectModel _project;
  const ProjectBoardPage(this._project);
  @override
  // ignore: no_logic_in_create_state
  _ProjectBoardPageState createState() => _ProjectBoardPageState(_project);
}

class _ProjectBoardPageState extends State<ProjectBoardPage>
    with TickerProviderStateMixin {
  final ProjectModel project;
  TabController _swimlaneController;
  List<Tab> tabs = [];
  List<Widget> pages = [];
  _ProjectBoardPageState(this.project) {
    _swimlaneController = TabController(
      vsync: this,
      length: 0, // TODO project.getSwimlaneCount()
    );
    // for (int i = 0; i < project.getSwimlaneCount(); i++) {
    //   tabs.add(Tab(text: project.getSwimlaneAt(i).name));
    //   pages.add(Swimlane(project.getSwimlaneAt(i)));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: project.buildTitle(context),
        bottom: TabBar(
          controller: _swimlaneController,
          isScrollable: true,
          tabs: tabs,
        ),
      ),
      body: Stack(children: [
        project.buildBgImage(width: double.infinity, height: double.infinity),
        TabBarView(
          controller: _swimlaneController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ]),
    );
  }
}
