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
