import 'package:flutter/material.dart';
import '../../data/models/comment.dart';
import '../../res/kanboard/api_procedures/comment_procedures.dart';
import '../singletons/kanboard_api_client.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// the comment management
///
/// It includes the following functionality:
///   - Create Comment
///   - Update Comment
///   - Remove Comment
///   - Individual Comment retrieval based on id
///   - Bulk Comment retrieval based on task id
///
class CommentRepository {
  static final CommentRepository _instance = CommentRepository._constructor();

  factory CommentRepository() => _instance;
  CommentRepository._constructor(); // empty constructor

  Future<int> createComment({
    @required int taskId,
    @required int userId,
    @required String content,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: commentCommands[CommentProcedures.create],
      params: {
        'task_id': taskId,
        'user_id': userId,
        'content': content,
      },
    );
    return statusCode;
  }

  Future<CommentModel> getCommentById(int commentId) async {
    final CommentModel comment = await KanboardAPI().getObject<CommentModel>(
      command: commentCommands[CommentProcedures.getById],
      params: {'comment_id': commentId},
    );
    return comment;
  }

  Future<List<CommentModel>> getAllCommentForTask(int taskId) async {
    final List<CommentModel> comments =
        await KanboardAPI().getObjectList<CommentModel>(
      command: commentCommands[CommentProcedures.getAll],
      params: {'task_id': taskId},
    );
    return comments;
  }

  Future<bool> updateComment({
    @required int commentId,
    @required String content,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: commentCommands[CommentProcedures.update],
      params: {
        'comment_id': commentId,
        'content': content,
      },
    );
    return status;
  }

  Future<bool> removeComment(int commentId) async {
    final bool status = await KanboardAPI().getBool(
      command: commentCommands[CommentProcedures.remove],
      params: {'comment_id': commentId},
    );
    return status;
  }
}
