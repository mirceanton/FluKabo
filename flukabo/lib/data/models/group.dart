class Group {
  int _id;
  int _eId;
  String _name;

  Group({String name, int id, int eId})
      : _id = id,
        _eId = eId,
        _name = name;
  Group.fromJson(Map<String, String> json)
      : _id = int.parse(json['id']),
        _eId = json['external_id'].isEmpty ? 0 : int.parse(json['external_id']),
        _name = json['name'];
  Group.empty();

  int get id => _id;
  int get externalID => _eId;
  String get name => _name;
}
