import 'package:flukabo/data/models/models.dart';

String parseToString(String json) => json == 'null' ? '' : json;

double parseToDouble(String json) {
  if (json.isEmpty) return 0.0;
  try {
    return double.parse(json);
  } catch (_) {
    return 0.0;
  }
}

int parseToInt(String json) {
  if (json.isEmpty) return 0;
  try {
    return int.parse(json);
  } catch (_) {
    return 0;
  }
}

bool parseToBool(String json) =>
    json.isNotEmpty && (json == '1' || json == 'true');

T parseToObject<T>(Map<String, dynamic> json) {
  switch (T) {
    case ColumnModel:
      return ColumnModel.fromJson(json) as T;
    case ExtendedColumnModel:
      return ExtendedColumnModel.fromJson(json) as T;
    case EventModel:
      return EventModel.fromJson(json) as T;
    case GroupModel:
      return GroupModel.fromJson(json) as T;
    case ProjectModel:
      return ProjectModel.fromJson(json) as T;
    case SwimlaneModel:
      return SwimlaneModel.fromJson(json) as T;
    case ExtendedSwimlaneModel:
      return ExtendedSwimlaneModel.fromJson(json) as T;
    case TagModel:
      return TagModel.fromJson(json) as T;
    case TaskModel:
      return TaskModel.fromJson(json) as T;
    case ExtendedTaskModel:
      return ExtendedTaskModel.fromJson(json) as T;
    case UserModel:
      return UserModel.fromJson(json) as T;
    case CommentModel:
      return CommentModel.fromJson(json) as T;
    case BoardModel:
      return BoardModel.fromJson(json) as T;
    case CategoryModel:
      return CategoryModel.fromJson(json) as T;
    default:
      return null;
  }
}

List<T> parseToList<T extends AbstractDataModel>(List json) {
  final List<T> list = [];
  for (int i = 0; i < json.length; i++) {
    list.add(
      parseToObject<T>(json[i] as Map<String, dynamic>),
    );
  }
  return list;
}
