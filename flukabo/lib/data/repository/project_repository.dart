import 'dart:convert';

import 'package:flukabo/data/models/project.dart';
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

  ///
  /// [createProject] returns true if the Project was succesfully created or
  /// false otherwise.
  ///
  /// [name] is required as all Projects must have a name
  /// [description], [ownerId] and [identifier] are optional parameters.
  /// If no values are provided, [description] will be empty, the [ownerId] will
  /// be '0' and the [identifier] will also be empty
  ///
  /// the [id] of the newly created Project is the [statusCode] (as long as it
  /// is not 0. then if means there was an error)
  ///
  Future<bool> createProject({
    @required String name,
    String description = '',
    int ownerId = 0,
    String identifier = '',
  }) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.create],
      params: {
        'name': name,
        'description': description,
        'owner_id': ownerId.toString(),
        'identifier': identifier,
      },
    );
    final String response = jsonDecode(json)['result'].toString();
    final int statusCode = response == 'false' ? 0 : int.parse(response);
    if (response == 'false') {
      print('Failed to create Project');
      return false;
    } else {
      print('Project created succesfully. ProjID: $statusCode');
      return true;
    }
  }

  ///
  ///[getProjectByName] returns a Project object if the given name is valid
  /// or throws a Failure otherwise (also throws failure if name doesn't exist)
  ///
  Future<ProjectModel> getProjectByName(String name) async {
    final String json = await KanboardAPI().getJson(
      command: projectCommands[ProjectProcedures.getByName],
      params: {'name': name},
    );
    final Map<String, dynamic> result =
        jsonDecode(json)['result'] as Map<String, dynamic>;
    if (result != null) {
      print('Successfully fetched project $name.');
      return ProjectModel.fromJson(result);
    } else {
      print('Failed to fetch user.');
      throw const Failure('Failed to fetch user.');
    }
  }
}
