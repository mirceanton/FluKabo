import 'package:flutter/material.dart';
import '../../../data/models/project.dart';
import '../../../res/dimensions.dart';

///
/// A Caard used to showcase a project
/// The card has a Stack Widget at it's core, overlaying 3 main elements:
///   1. At the bottom, a background image => [project.buidBgImage(...)]
///   2. The middle layoer is the actual content => [Content]
///   3. The top most layer is a [ClickArea], to handle the tap functionality
///
class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  const ProjectCard(this.project);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Stack(
        children: <Widget>[
          project.buildBgImage(
            width: cardWidth,
            height: cardHeight,
          ),
          Content(project),
          ClickArea(project),
        ],
      ),
    );
  }
}

///
/// A container sandwiched by 2 Expanded Widgets, which has the project name and
/// the project privacy icon on a semi-transparent black background
/// The top Expanded has a flex of 3, and the bottom one a flex of 1, showing
/// the container in the bottom half of the screen
///
class Content extends StatelessWidget {
  final ProjectModel project;
  const Content(this.project);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      child: Column(
        children: <Widget>[
          Expanded(flex: 3, child: Container()),
          Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black45,
              width: 200,
              child: Column(
                children: [
                  project.buildTitle(context),
                  const SizedBox(height: 4.0),
                  Icon(project.privacyIcon),
                ],
              )),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

///
/// This is nothing more than an [InkWell] with the [onTap] = [project.navigate]
/// to navigate to the ProjectBoardPage of the project
///
class ClickArea extends StatelessWidget {
  final ProjectModel project;
  const ClickArea(this.project);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.transparent,
        width: cardWidth,
        height: cardHeight,
        child: InkWell(
          onTap: () => project.navigate(context),
        ),
      ),
    );
  }
}
