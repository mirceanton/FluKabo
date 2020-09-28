import 'package:flukabo/data/models/models.dart';
import 'package:flukabo/ui/templates/tag/tag_chip.dart';
import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final List<TagModel> tags;
  const TagList(this.tags);
  @override
  Widget build(BuildContext context) {
    if (tags == null || tags.isEmpty) {
      return const SizedBox(width: 1, height: 1);
    } else {
      return Container(
        height: 20.0,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: tags.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemBuilder: (context, index) => TagChip(tags[index]),
        ),
      );
    }
  }
}
