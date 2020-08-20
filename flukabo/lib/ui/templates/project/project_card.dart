import 'package:flukabo/data/models/project.dart';
import 'package:flukabo/res/dimensions.dart';
import 'package:flutter/material.dart';

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
