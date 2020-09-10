abstract class AbstractDataModel {
  ///
  /// returns a String containing the class name
  /// For example, the class ColumnModel will return 'column'
  ///
  String get type;

  ///
  /// Will call the [.fromJson] constructor and return a new instance of the
  /// object
  ///
  dynamic fromJson(Map<String, dynamic> json);
}
