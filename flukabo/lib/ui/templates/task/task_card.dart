import 'package:flukabo/data/models/models.dart';
import 'package:flukabo/ui/templates/tag_list.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../template_commons.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard({this.task});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        child: Stack(
          children: [
            Positioned.fill(
              child: InkWell(onTap: () => task.navigate(context)),
            ),
            ContentArea(task: task),
          ],
        ),
      ),
    );
  }
}

class ContentArea extends StatelessWidget {
  final TaskModel task;
  const ContentArea({this.task});

  List<Widget> _getIndicators(TaskModel task) {
    final List<Widget> indicators = [];
    if (task.hasDescription()) {
      indicators.add(const Icon(MdiIcons.text));
      indicators.add(VerticalDivider());
    }
    indicators.add(Text('P${task.priority}'));
    indicators.add(VerticalDivider());
    indicators.add(Text('D${task.complexity}'));

    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TagList(tags: task.tags),
          const Divider(),
          TitleTemplate(
            objectId: task.id,
            title: task.title,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Theme.of(context).dividerColor,
    );
  }
}
