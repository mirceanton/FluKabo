import 'package:flukabo/data/models/link.dart';
import 'package:flukabo/data/singletons/kanboard_api_client.dart';
import 'package:flukabo/res/kanboard/api_procedures/link_api_procedures.dart';
import 'package:flutter/material.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// link management
///
/// It includes the following functionality:
///   - Create new Link
///   - Retrieve Link
///     - By Id
///     - By Label
///     - By Opposite
///   - Retrieve All Links
///   - Update Link
///   - Remove Link
///
class LinkRepository {
  static final LinkRepository _instance = LinkRepository._constructor();

  factory LinkRepository() => _instance;
  LinkRepository._constructor(); // empty constructor

  Future<int> createLint({
    @required String label,
    String oppositeLabel,
  }) async {
    final int statusCode = await KanboardAPI().getInt(
      command: linkCommands[LinkProcedures.create],
      params: {
        'label': label,
        'opposite_label': oppositeLabel ?? '',
      },
    );
    return statusCode;
  }

  Future<LinkModel> getLinkById(int linkId) async {
    final LinkModel link = await KanboardAPI().getObject<LinkModel>(
      command: linkCommands[LinkProcedures.getById],
      params: {'link_id': linkId},
    );
    return link;
  }

  Future<LinkModel> getLinkByLabel(String label) async {
    final LinkModel link = await KanboardAPI().getObject<LinkModel>(
      command: linkCommands[LinkProcedures.getByLabel],
      params: {'label': label},
    );
    return link;
  }

  Future<LinkModel> getOppositeLink(int linkId) async {
    final int oppositeId = await KanboardAPI().getInt(
      command: linkCommands[LinkProcedures.getOpposite],
      params: {'link_id': linkId},
    );
    final LinkModel opposite = await getLinkById(oppositeId);
    return opposite;
  }

  Future<List<LinkModel>> getAllLinks() async {
    final List<LinkModel> links = await KanboardAPI().getObjectList<LinkModel>(
      command: linkCommands[LinkProcedures.getAll],
      params: null,
    );
    return links;
  }

  Future<bool> updateLink({
    @required int linkId,
    @required String label,
    @required int oppositeId,
  }) async {
    final bool status = await KanboardAPI().getBool(
      command: linkCommands[LinkProcedures.update],
      params: {
        'link_id': linkId,
        'label': label,
        'oppsite_link_id': oppositeId,
      },
    );
    return status;
  }

  Future<bool> removeLink(int linkId) async {
    final bool status = await KanboardAPI().getBool(
      command: linkCommands[LinkProcedures.remove],
      params: {'link_id': linkId},
    );
    return status;
  }
}
