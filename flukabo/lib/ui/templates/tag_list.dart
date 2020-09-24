import 'package:flukabo/data/models/models.dart';
import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final List<TagModel> tags;
  const TagList({this.tags});
  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox();
    } else {
      return Container(
        height: 36.0,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: tags.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemBuilder: (context, index) => Chip(
            label: Text(tags[index].name),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            backgroundColor: tags[index].color,
          ),
        ),
      );
    }
  }
}
