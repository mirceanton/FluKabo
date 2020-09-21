import '../../data/helpers/json_parser.dart';
import '../../data/models/abstract_model.dart';

class LinkModel extends AbstractDataModel {
  int _id;
  String _label;
  int _oppositeId;

  // Constructors
  LinkModel.empty();
  LinkModel.fromJson(Map<String, dynamic> json) {
    _id = parseToInt(json['id'].toString());
    _label = parseToString(json['label'].toString());
    _oppositeId = parseToInt(json['opposite_id'].toString());
  }

  // Getters
  int get id => _id;
  String get label => _label;
  int get oppositeId => _oppositeId;
  @override
  String get type => 'link';

  @override
  LinkModel fromJson(Map<String, dynamic> json) => LinkModel.fromJson(json);
}
