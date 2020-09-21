import 'package:flutter/material.dart';
import '../../../data/models/project.dart';
import '../../../ui/templates/project/project_card.dart';
import '../../../ui/templates/project/project_tile.dart';

///
/// A custom list view that can handle displaying the Projects in 2 fashions:
///   1. Vertical scrolling, ListTile-style items
///   2. Horizontal scrolling, card-style items
/// If the list is vertical, then a regular [Divider] is used as a separator.
/// If the list is horizontal, we don't want a separator per se, just a slightly
///   larger gap between the elements. As such, a [SizedBox] is implemented, with
///   a width of 4
///
/// [projects] is the actual list of projects passed to the [ListView]
/// [showCards] basically switches between style 1 and 2 mentioned above
/// [width] & [height] are the dimensions imposed to the Container the ListView
///   is wrapped with
///
class ProjectListView extends StatelessWidget {
  final List<ProjectModel> projects;
  final bool showCards;
  final double width, height;

  const ProjectListView({
    @required this.projects,
    @required this.showCards,
    @required this.width,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ListView.separated(
          scrollDirection: showCards ? Axis.horizontal : Axis.vertical,
          itemCount: projects.length,
          separatorBuilder: (context, index) {
            if (showCards) {
              return const SizedBox(width: 4.0);
            } else {
              return const Divider(height: 1.0);
            }
          },
          itemBuilder: (context, index) {
            if (showCards) {
              return ProjectCard(projects[index]);
            } else {
              return ProjectTile(projects[index]);
            }
          }),
    );
  }
}
