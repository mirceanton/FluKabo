import 'package:flukabo/ui/templates/project/project_commons.dart';
import 'package:flutter/material.dart';
import '../../../data/models/project.dart';
import '../../../res/dimensions.dart';
import '../template_commons.dart';

///
/// A basic List tile showcasing a project
/// The [subtitle] is the project name, the [subtitle] is the project description
/// The [leading] widget is a 48px wide square image of the project.bgimage
/// [onTap] navigates to the ProjectBoardPage of the project
///
class ProjectTile extends StatelessWidget {
  final ProjectModel project;
  const ProjectTile(this.project);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => project.navigate(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      leading: ProjectBackground(
        width: tileSize,
        height: tileSize,
        radius: 8.0,
        image: project.backgroundImage,
        title: project.name,
      ),
      title: TitleTemplate(
        text: project.name,
        color: Theme.of(context).textTheme.headline6.color,
      ),
      subtitle: SubtitleTemplate(subtitle: project.description),
      trailing: ProjectStarIcon(isStarred: project.isStarred),
    );
  }
}
