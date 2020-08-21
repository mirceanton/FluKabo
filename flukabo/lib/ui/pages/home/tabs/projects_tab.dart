import 'package:flukabo/data/models/project.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'abstract_tab_class.dart';

class ProjectsTab extends HomeTab {
  final List<ProjectModel> _projects;
  const ProjectsTab(this._projects);

  @override
  String getName() => 'Projects';
  @override
  IconData getIcon() => MdiIcons.bulletinBoard;

  @override
  Future<void> refresh() async {
    //TODO
  }

  // TODO
  @override
  Widget buildSelf() {
    return Center(
      child: Text(
        getName(),
      ),
    );
  }
}
