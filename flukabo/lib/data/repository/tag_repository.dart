import 'dart:convert';

import 'package:flukabo/data/models/models.dart';
import 'package:flukabo/data/models/tag.dart';
import 'package:flukabo/data/repository/task_repository.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/tag_procedures.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the tags management functionality provided by the web app.
///
/// It includes the following functionality:
///   - Create tag
///   - Get tag
///     - by project
///     - by task
///     - all
///   - Update tag
///   - Remove tag
///   - Link tag to task
///
class TagRepository {
  static final TagRepository _instance = TagRepository._constructor();

  factory TagRepository() => _instance;
  TagRepository._constructor(); // empty constructor

  ///
  /// [createTag] returns the id of the newly created tag if the creation was
  /// successfull. If the creation failed, an instance of Failure is thrown
  ///
  /// all tags are linked to projects, so [projectId] is a required field
  /// Also, all tags are just a string of text, so the field [tagName] is also
  /// required
  ///
  Future<int> createTag({
    @required int projectId,
    @required String tagName,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: tagCommands[TagProcedures.create],
      params: {
        'project_id': projectId.toString(),
        'tag': tagName,
      },
    );
    return statusCode;
  }

  ///
  /// [getAllTags] returns a list of all of the available tags
  /// If the api call failed for some reason, an instance of Failure is thrown
  ///
  Future<List<TagModel>> getAllTags() async {
    final List<TagModel> tags = await KanboardAPI().getObjectList<TagModel>(
      command: tagCommands[TagProcedures.getAll],
      params: {},
    );
    return tags;
  }

  Future<TagModel> getTagById(int tagId) async {
    final List<TagModel> allTags = await getAllTags();
    final int index = allTags.indexWhere((element) => element.id == tagId);
    if (index == -1) {
      print('No such tag found');
      throw const Failure('No tag matches given id');
    } else {
      return allTags[index];
    }
  }

  Future<TagModel> getTagByName({
    @required String tagName,
    @required int projectId,
  }) async {
    final List<TagModel> allTags = await getTagsByProject(projectId);
    final int index = allTags.indexWhere((element) => element.name == tagName);
    if (index == -1) {
      print('No such tag found');
      throw const Failure('No tag matches given name');
    } else {
      return allTags[index];
    }
  }

  ///
  /// [getTagsByProject] returns a list of all of the tags associated to the
  /// project identified by the [projectId]
  /// If the api call failed for some reason, an instance of Failure is thrown
  ///
  Future<List<TagModel>> getTagsByProject(int projectId) async {
    final List<TagModel> tags = await KanboardAPI().getObjectList<TagModel>(
      command: tagCommands[TagProcedures.getByProject],
      params: {'project_id': projectId.toString()},
    );
    return tags;
  }

  ///
  /// [updateTag] returns true if the name of the tag [tagId] was changed to
  /// [tagName] or false if the change failed
  /// If the api call failed for some reason, an instance of Failure is thrown
  ///
  Future<bool> updateTag({
    @required int tagId,
    @required String tagName,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: tagCommands[TagProcedures.update],
      params: {
        'tag_id': tagId.toString(),
        'tag': tagName,
      },
    );
    return status;
  }

  ///
  /// [removeTag] returns true if the tag was successfully removed from the
  /// database
  ///! This action cannot be undone
  ///
  Future<bool> removeTag(int tagId) async {
    final bool status = await KanboardAPI().getBool(
      command: tagCommands[TagProcedures.remove],
      params: {'tag_id': tagId.toString()},
    );
    return status;
  }

  Future<List<String>> getTaskTagNames(int taskId) async {
    final Map<String, dynamic> map = jsonDecode(await KanboardAPI().getJson(
      command: tagCommands[TagProcedures.getByTask],
      params: {'task_id': taskId},
    ))['result'] as Map<String, dynamic>;
    final List<String> tags = [];
    map.forEach((key, value) {
      tags.add(value.toString());
    });
    return tags;
  }

  Future<List<TagModel>> getTaskTags(int taskId) async {
    final Map<String, dynamic> map = jsonDecode(await KanboardAPI().getJson(
      command: tagCommands[TagProcedures.getByTask],
      params: {'task_id': taskId},
    ))['result'] as Map<String, dynamic>;
    final List<int> ids = [];
    final List<TagModel> tags = [];
    map.forEach((key, value) {
      ids.add(int.parse(key.toString()));
    });
    for (int i = 0; i < ids.length; i++) {
      tags.add(await getTagById(ids[i]));
    }
    return tags;
  }

  Future<bool> setTaskTags({
    @required int projectId,
    @required int taskId,
    @required List<String> tagNames,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: tagCommands[TagProcedures.assign],
      params: {
        'project_id': projectId,
        'task_id': taskId,
        'tags': tagNames,
      },
    );
    return status;
  }

  Future<bool> addTagToTask(int taskId, String tagName) async {
    final List<String> tags = await getTaskTagNames(taskId);
    final TaskModel task = await TaskRepository().getTaskById(taskId);
    tags.add(tagName);
    final bool status = await setTaskTags(
      projectId: task.projectId,
      taskId: taskId,
      tagNames: tags,
    );
    return status;
  }

  Future<bool> removeTagFromTask(int taskId, String tagName) async {
    final List<String> tags = await getTaskTagNames(taskId);
    final TaskModel task = await TaskRepository().getTaskById(taskId);
    tags.remove(tagName);
    final bool status = await setTaskTags(
      projectId: task.projectId,
      taskId: taskId,
      tagNames: tags,
    );
    return status;
  }
}
