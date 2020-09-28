import 'package:flukabo/data/models/models.dart';
import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final TagModel tag;
  const TagChip(this.tag);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag.name),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      backgroundColor: tag.color,
    );
  }
}
