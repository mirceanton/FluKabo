import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../../ui/templates/tag/tag_list.dart';
import '../../../ui/templates/user/user_icon.dart';

import '../../commons.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Positioned.fill(
            child: InkWell(onTap: () => task.navigate(context)),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TagList(task.tags),
                const Divider(),
                Container(
                  margin: const EdgeInsets.only(right: 36),
                  child: TitleTemplate(
                    objectId: task.id,
                    title: task.title,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(children: task.modifierIcons),
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            right: 16,
            child: UserIcon(task.owner),
          )
        ],
      ),
    );
  }
}
