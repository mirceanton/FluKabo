import '../../data/models/board.dart';
import '../../data/singletons/kanboard_api_client.dart';
import '../../res/kanboard/api_procedures/board_procedures.dart';

///
/// This is a singleton meant to encapsulate all the methods associated with
/// board management
///
/// It includes the following functionality:
///   - Board retrieval based on project ID
///
class BoardRepository {
  static final BoardRepository _instance = BoardRepository._constructor();

  factory BoardRepository() => _instance;
  BoardRepository._constructor(); // empty constructor

  Future<BoardModel> getBoardForProject(int projectId) async {
    final BoardModel board = await KanboardAPI().getObject<BoardModel>(
      command: boardCommands[BoardProcedures.getByProject],
      params: {'project_id': projectId},
    );
    return board;
  }
}
