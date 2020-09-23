import 'package:flutter/material.dart';
import '../../../data/models/project.dart';
import '../../../res/dimensions.dart';

///
/// A basic List tile showcasing a project
/// The [title] is the project name, the [subtitle] is the project description
/// The [leading] widget is a 48px wide square image of the project.bgimage
/// [onTap] navigates to the ProjectBoardPage of the project
///
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
          radius: 8.0,
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
