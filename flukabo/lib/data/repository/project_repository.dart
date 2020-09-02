import 'dart:convert';

import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/project_procedures.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with the
/// project management feature provided to all users.
///
/// It includes the following functionality:
///   - C.R.U.D operations:
///     - Create project
///     - Read project by id
///     - Read project by name
///     - Update project
///     - Delete project
///   - Enable/Disable Project
///   - Enable/Disable Public Access
///   - Get Activity Feed
///
class ProjectRepository {
  static final ProjectRepository _instance = ProjectRepository._constructor();

  factory ProjectRepository() => _instance;
  ProjectRepository._constructor(); // empty constructor

}
