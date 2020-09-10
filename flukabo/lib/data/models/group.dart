import 'package:flukabo/data/helpers/json_parser.dart';
import 'package:flukabo/data/models/abstract_model.dart';

class GroupModel extends AbstractDataModel {
  int _id;
  int _eId;
  String _name;

  // Constructors
  GroupModel.empty();
  GroupModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _eId = parseToInt(json['external_id'].toString());
    _name = parseToString(json['name'].toString());
  }

  // Getters for private fields
  int get id => _id;
  int get externalID => _eId;
  String get name => _name;
  @override
  String get type => 'group';

  @override
  GroupModel fromJson(Map<String, dynamic> json) => GroupModel.fromJson(json);
}
