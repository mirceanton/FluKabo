import 'package:flukabo/ui/pages/project/project_board_page.dart';
import 'package:flutter/material.dart';

class ProjectModel {
  final int _id;
  final String _name;
  final String _description;
  final String _backgroundImage;
  final bool _private;

  ProjectModel({
    int id,
    String name,
    String description,
    String backgroundImage = "https://source.unsplash.com/random",
    bool isPrivate,
  })  : _id = id,
        _name = name,
        _description = description,
        _backgroundImage = backgroundImage,
        _private = isPrivate;

  // Getters for private fields
  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get backgroundImage => _backgroundImage;
  bool get isPrivate => _private;
  IconData get privacyIcon => isPrivate ? Icons.lock : null;

  Set<Future> navigate(BuildContext context) {
    return {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectBoardPage(this),
        ),
      )
    };
  }

  // Widget Generating methods
  Widget buildBgImage({@required double width, @required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Hero(
        tag: "${_name}_img",
        child: Image.network(
          _backgroundImage,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Hero(
      tag: "${_name}_title",
      child: Material(
        color: Colors.transparent,
        child: Text(
          _name,
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1.1,
            color: Theme.of(context).primaryTextTheme.bodyText1.color,
          ),
        ),
      ),
    );
  }
}
