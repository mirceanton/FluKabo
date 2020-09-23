import 'package:flukabo/bloc/data/board/board_bloc.dart';
import 'package:flukabo/data/models/board.dart';
import 'package:flukabo/ui/templates/swimlane_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/project.dart';
import '../../commons.dart';

class ProjectBoardPage extends StatefulWidget {
  final ProjectModel _project;
  const ProjectBoardPage(this._project);
  @override
  // ignore: no_logic_in_create_state
  _ProjectBoardPageState createState() => _ProjectBoardPageState(_project);
}

class _ProjectBoardPageState extends State<ProjectBoardPage>
    with TickerProviderStateMixin {
  final ProjectModel project;
  TabController _tabController;
  List<Tab> tabs = [];
  List<Widget> pages = [];
  _ProjectBoardPageState(this.project);

  Widget _builder(BuildContext context, BoardState state) {
    if (state is BoardLoading) {
      print('Board loading...');
      return buildLoading();
    } else if (state is BoardLoaded) {
      print('Board loaded.');
      final BoardModel board = state.board;
      _tabController = TabController(
        length: board.swimlanes.length,
        vsync: this,
      );
      tabs.clear();
      pages.clear();
      for (int i = 0; i < board.swimlanes.length; i++) {
        tabs.add(Tab(text: board.swimlanes[i].name));
        pages.add(SwimlaneTemplate(swimlane: board.swimlanes[i]));
      }
      return _buildContent(context, board);
    } else if (state is BoardError) {
      print('Board error.');
      return _buildError();
    }

    context.bloc<BoardBloc>().add(FetchBoard(projectId: project.id));
    return buildInitial();
  }

  void _listener(BuildContext context, BoardState state) {
    if (state is BoardError) {
      showSnackbar(context: context, content: state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardBloc(),
      child: BlocConsumer<BoardBloc, BoardState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  Widget _buildError() => const Center(child: Text("error")); //FIXME

  PreferredSizeWidget _getTabBar(int count) {
    if (count == 1) {
      return null;
    } else {
      return TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: tabs,
      );
    }
  }

  Widget _buildContent(BuildContext context, BoardModel board) {
    return Scaffold(
      appBar: AppBar(
        title: project.buildTitle(context),
        bottom: _getTabBar(board.swimlanes.length),
      ),
      body: Stack(
        children: [
          project.buildBgImage(
            width: double.infinity,
            height: double.infinity,
            radius: 0,
          ),
          TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: pages,
          ),
        ],
      ),
    );
  }
}
