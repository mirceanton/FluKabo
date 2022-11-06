import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../../ui/templates/column/column_template.dart';

class SwimlaneTemplate extends StatelessWidget {
  final ExtendedSwimlaneModel swimlane;
  const SwimlaneTemplate(this.swimlane);

  @override
  Widget build(BuildContext context) {
    final List<Widget> columns = [];
    for (int i = 0; i < swimlane.columnsCount; i++) {
      columns.add(ColumnTemplate(swimlane.columns[i]));
    }
    return PageView(children: columns);
  }
}
