import 'dart:convert';

import 'package:flukabo/data/models/tag.dart';
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
  /// [createTag] returns true if the tag was created successfully ot false
  /// otherwise
  ///
  /// all tags are linked to projects, so [projectId] is a required field
  /// Also, all tags are just a string of text, so the field [tagName] is also
  /// required
  ///
  Future<bool> createTag({
    @required int projectId,
    @required String tagName,
  }) async {
    final String json = await KanboardAPI().getJson(
      command: tagCommands[TagProcedures.create],
      params: {
        'project_id': projectId.toString(),
        'tag': tagName,
      },
    );
    final String response = jsonDecode(json)['result'].toString();
    if (response == 'false' || response == 'null' || response.isEmpty) {
      print('Failed to create tag');
      return false;
    } else {
      final int statusCode = response == 'false' ? 0 : int.parse(response);
      print('Tag created succesfully. ID: $statusCode');
      return true;
    }
  }

  Future<List<TagModel>> getAllTags() async {
    final List<TagModel> tags = [];
    final String json = await KanboardAPI().getJson(
      command: tagCommands[TagProcedures.getAll],
      params: {},
    );
    final List result = jsonDecode(json)['result'] as List;
    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        tags.add(
          TagModel.fromJson(Map.from(result[i] as Map<String, dynamic>)),
        );
      }
      print('Succesfully fetched ${tags.length} tags.');
      return tags;
    } else {
      print('Failed to fetch tags.');
      throw const Failure('Failed to fetch tags.');
    }
  }

  Future<List<TagModel>> getTagsByProject(int projectId) async {
    final List<TagModel> tags = [];
    final String json = await KanboardAPI().getJson(
      command: tagCommands[TagProcedures.getByProject],
      params: {'project_id': projectId.toString()},
    );
    final List result = jsonDecode(json)['result'] as List;
    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        tags.add(
          TagModel.fromJson(Map.from(result[i] as Map<String, dynamic>)),
        );
      }
      print(
        'Succesfully fetched ${tags.length} tags linked to the project $projectId.',
      );
      return tags;
    } else {
      print('Failed to fetch tags.');
      throw const Failure('Failed to fetch tags.');
    }
  }

  Future<bool> updateTag({
    @required int tagId,
    @required String tagName,
  }) async {
    final String json = await KanboardAPI().getJson(
      command: tagCommands[TagProcedures.update],
      params: {
        'tag_id': tagId.toString(),
        'tag': tagName,
      },
    );
    final String response = jsonDecode(json)['result'].toString();
    if (response != 'false' && response != 'null' && response.isNotEmpty) {
      print('Tag $tagId name changed to $tagName.');
      return true;
    } else {
      print('Failed to update tag');
      return false;
    }
  }

  Future<bool> removeTag(int tagId) async {
    final String json = await KanboardAPI().getJson(
      command: tagCommands[TagProcedures.remove],
      params: {
        'tag_id': tagId.toString(),
      },
    );
    final String response = jsonDecode(json)['result'].toString();
    if (response != 'false' && response != 'null' && response.isNotEmpty) {
      print('Tag $tagId removed successfully.');
      return true;
    } else {
      print('Failed to remove tag');
      return false;
    }
  }
}