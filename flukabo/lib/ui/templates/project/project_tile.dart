import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/res/dimensions.dart';
import 'package:flutter/material.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel project;
  const ProjectTile(this.project);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => project.navigate(context),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        leading: project.buildBgImage(
          width: tileSize,
          height: tileSize,
        ),
        title: Row(
          children: [
            project.buildTitle(context),
            const SizedBox(width: 6.0),
            Icon(project.privacyIcon)
          ],
        ),
        subtitle: Text(project.description),
      ),
    );
  }
}
