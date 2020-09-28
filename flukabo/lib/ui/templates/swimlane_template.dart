import 'package:flukabo/data/models/models.dart';
import 'package:flukabo/ui/templates/column_template.dart';
import 'package:flutter/material.dart';

class SwimlaneTemplate extends StatelessWidget {
  final ExtendedSwimlaneModel swimlane;
  const SwimlaneTemplate({this.swimlane});

  @override
  Widget build(BuildContext context) {
    final List<Widget> columns = [];
    for (int i = 0; i < swimlane.columnsCount; i++) {
      columns.add(ColumnTemplate(column: swimlane.columns[i]));
    }
    return PageView(children: columns);
  }
}
