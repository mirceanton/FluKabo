import 'package:flutter/material.dart';

class ProjectModel {
  final int _id;
  final String _name;
  final String _description;
  final String _backgroundImage;
  final bool _private;

  ProjectModel({
    int id,
    String name,
    String description,
    String backgroundImage = "https://source.unsplash.com/random",
    bool isPrivate,
  })  : _id = id,
        _name = name,
        _description = description,
        _backgroundImage = backgroundImage,
        _private = isPrivate;

  // Getters for private fields
  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get backgroundImage => _backgroundImage;
  bool get isPrivate => _private;
  IconData get privacyIcon => isPrivate ? Icons.lock : null;
}
