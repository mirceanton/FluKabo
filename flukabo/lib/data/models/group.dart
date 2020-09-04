class GroupModel {
  int _id;
  int _eId;
  String _name;

  GroupModel({String name, int id, int eId})
      : _id = id,
        _eId = eId,
        _name = name;
  GroupModel.fromJson(Map<String, dynamic> json)
      : _id = int.parse(json['id'].toString()),
        _eId = json['external_id'].toString().isEmpty
            ? 0
            : int.parse(json['external_id'].toString()),
        _name = json['name'].toString();
  GroupModel.empty();

  int get id => _id;
  int get externalID => _eId;
  String get name => _name;
}
