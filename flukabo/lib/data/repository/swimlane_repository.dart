import 'package:flukabo/data/models/swimlane.dart';
import 'package:flukabo/res/kanboard/api_procedures/swimlane_procedures.dart';
import 'package:flutter/material.dart';

import '../singletons/kanboard_api_client.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the Swimlane management
///
/// It includes the following functionality:
///   - Create Swimlane
///   - Update Swimlane
///   - Change the position of a Swimlane
///   - Remove Swimlane
///   - Individual Swimlane retrieval (by id, by name)
///   - Bulk Swimlane retrieval (all, active)
///   - Swimlane enable/disable
///
class SwimlaneRepository {
  static final SwimlaneRepository _instance = SwimlaneRepository._constructor();

  factory SwimlaneRepository() => _instance;
  SwimlaneRepository._constructor(); // empty constructor

  Future<int> createSwimlane({
    @required int projectId,
    @required String name,
    String description,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: swimlaneCommands[SwimlaneProcedures.create],
      params: {
        'project_id': projectId,
        'name': name,
        'description': description ?? '',
      },
    );
    return statusCode;
  }

  Future<SwimlaneModel> getSwimlaneById(int swimlaneId) async {
    final SwimlaneModel swimlane = await KanboardAPI().getObject<SwimlaneModel>(
      command: swimlaneCommands[SwimlaneProcedures.getById],
      params: {'swimlane_id': swimlaneId},
    );
    return swimlane;
  }

  Future<SwimlaneModel> getSwimlaneByName({
    @required int projectId,
    @required String swimlaneName,
  }) async {
    final SwimlaneModel swimlane = await KanboardAPI().getObject<SwimlaneModel>(
      command: swimlaneCommands[SwimlaneProcedures.getByName],
      params: {
        'project_id': projectId,
        'name': swimlaneName,
      },
    );
    return swimlane;
  }

  Future<List<SwimlaneModel>> getAllSwimlanes(int projectId) async {
    final List<SwimlaneModel> swimlanes =
        await KanboardAPI().getObjectList<SwimlaneModel>(
      command: swimlaneCommands[SwimlaneProcedures.getAll],
      params: {'project_id': projectId},
    );
    return swimlanes;
  }

  Future<List<SwimlaneModel>> getActiveSwimlanes(int projectId) async {
    final List<SwimlaneModel> swimlanes =
        await KanboardAPI().getObjectList<SwimlaneModel>(
      command: swimlaneCommands[SwimlaneProcedures.getActive],
      params: {'project_id': projectId},
    );
    return swimlanes;
  }

  Future<bool> updateSwimlane({
    @required int projectId,
    @required int swimlaneId,
    @required String name,
    String description,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: swimlaneCommands[SwimlaneProcedures.update],
      params: {
        'project_id': projectId,
        'swimlane_id': swimlaneId,
        'name': name,
        'description': description ?? '',
      },
    );
    return status;
  }

  Future<bool> changeSwimlanePosition({
    @required int projectId,
    @required int swimlaneId,
    @required int position,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: swimlaneCommands[SwimlaneProcedures.changePosition],
      params: {
        'project_id': projectId,
        'swimlane_id': swimlaneId,
        'position': position < 1 ? '1' : position,
      },
    );
    return status;
  }

  Future<bool> disableSwimlane({
    @required int projectId,
    @required int swimlaneId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: swimlaneCommands[SwimlaneProcedures.disable],
      params: {
        'project_id': projectId,
        'swimlane_id': swimlaneId,
      },
    );
    return status;
  }

  Future<bool> enableSwimlane({
    @required int projectId,
    @required int swimlaneId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: swimlaneCommands[SwimlaneProcedures.enable],
      params: {
        'project_id': projectId,
        'swimlane_id': swimlaneId,
      },
    );
    return status;
  }

  Future<bool> removeSwimlane({
    @required int projectId,
    @required int swimlaneId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: swimlaneCommands[SwimlaneProcedures.remove],
      params: {
        'project_id': projectId,
        'swimlane_id': swimlaneId,
      },
    );
    return status;
  }
}
