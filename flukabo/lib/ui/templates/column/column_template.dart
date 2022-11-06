import 'package:flutter/material.dart';

import '../../../data/models/column.dart';

class ColumnTemplate extends StatelessWidget {
  final ExtendedColumnModel column;
  const ColumnTemplate(this.column);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10,
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColumnTitle(column.title),
          const Divider(),
        ],
      ),
    );
  }
}

class ColumnTitle extends StatelessWidget {
  final String title;
  const ColumnTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.25,
      ),
    );
  }
}
