import 'package:flutter/material.dart';

import '../../../data/models/models.dart';

class TagChip extends StatelessWidget {
  final TagModel tag;
  const TagChip(this.tag);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.all(1.0),
        color: Theme.of(context).dividerColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: tag.color ?? Theme.of(context).cardColor,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                tag.name,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
