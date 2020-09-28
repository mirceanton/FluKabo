import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TaskIcon extends StatelessWidget {
  final int priorityStart, priorityEnd;
  final int priority;
  const TaskIcon({
    @required this.priority,
    @required this.priorityEnd,
    @required this.priorityStart,
  });
  @override
  Widget build(BuildContext context) {
    Color color;
    if (priorityStart == priorityEnd) {
      color = Colors.grey;
    } else {
      final double threshold = (priorityEnd - priorityStart) / 3;
      if (priority < threshold.toInt()) {
        color = Colors.green;
      } else if (priority < 2 * threshold.toInt()) {
        color = Colors.yellow;
      } else {
        color = Colors.red;
      }
    }
    return Icon(
      MdiIcons.circle,
      color: color,
      size: 48.0,
    );
  }
}
