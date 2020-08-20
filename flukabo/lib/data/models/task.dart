import 'package:flukabo/ui/pages/task/task_details_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TaskModel {
  final String _name;
  final String _description;
  final int _priority;
  final int _difficulty;

  TaskModel({
    String name = "",
    String description = "",
    int priority = 0,
    int difficulty = 0,
  })  : _name = name,
        _description = description,
        _priority = priority,
        _difficulty = difficulty;

  String get name => _name;
  String get description => _description;
  int get priority => _priority;
  int get difficulty => _difficulty;
  Color get priorityColor {
    // TODO this should probably be modified to have specific thresholds based
    // on the parent projects max and min priority
    if (priority < 2) {
      return Colors.green;
    } else if (priority < 4) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  bool hasDescription() => _description.isNotEmpty;

  Set<Future> navigate(BuildContext context) {
    return {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetailsPage(this),
        ),
      )
    };
  }

  Widget buildIcon() => Icon(
        MdiIcons.circle,
        size: 48.0,
        color: priorityColor,
      );
  Widget buildTitle() {
    return Hero(
      tag: "${_name}_title",
      child: Material(
        color: Colors.transparent,
        child: Text(
          _name,
          style: const TextStyle(
            fontSize: 16,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
