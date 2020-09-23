import 'package:flukabo/data/models/models.dart';
import 'package:flutter/material.dart';

class SwimlaneTemplate extends StatelessWidget {
  final ExtendedSwimlaneModel swimlane;
  const SwimlaneTemplate({this.swimlane});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(swimlane.name));
  }
}
