import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/abstract_model.dart';
import 'package:flukabo/data/models/swimlane.dart';

class BoardModel extends AbstractDataModel {
  List<ExtendedSwimlaneModel> _swimlanes;

  // Constructors
  BoardModel.empty();
  BoardModel.fromJson(Map<String, dynamic> json) {
    //! This needs to receive the entire json response, not just the 'result'
    //! part, as the result is not a map, but a list
    _swimlanes = parseToList<ExtendedSwimlaneModel>(json['result'] as List);
  }

  // Getters
  List<ExtendedSwimlaneModel> get swimlanes => _swimlanes;
  @override
  String get type => 'board';

  @override
  BoardModel fromJson(Map<String, dynamic> json) => BoardModel.fromJson(json);
}
