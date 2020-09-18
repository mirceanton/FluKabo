import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../../data/models/project.dart';
import '../../../data/models/task.dart';
import 'home.dart';
import 'tabs/abstract_tab_class.dart';

// This page is implemented as stateful in order to handle icon animations
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ///
  /// [_pageController] is the controller for the main pageView in the body
  /// This is used to handle jumping to the appropriate index in the pageView
  /// based on the index of the clicked button from the bottom navbar.
  ///
  final PageController _pageController = PageController();

  ///
  /// [_tabs] a list of HomeTab items, containing the tabs themselves,
  /// in a structured data format.
  /// See './tabs/abstract_tab.dart' for details
  /// Essentially, these items each contain x important methods:
  ///   - getName() => returns the name associated to the tab as a string
  ///   - getIcon() => returns the icon (IconData) associated to the tab
  ///   - getBody() => returns the actual content of the tab itself, as a widget
  ///
  final List<HomeTab> _tabs = [];

  ///
  /// [_currentTab] is pretty self explanatory. It holds the index of the current
  /// tab from the [_tabs] list
  ///
  int _currentTab = 0;

  ///
  /// [animDurationSlow] and [animDurationFast] are default values
  /// for the duration of the animations found in this page.
  /// Fast animations are twice as fast as slow ones.
  ///
  static const Duration animDurationSlow = Duration(milliseconds: 350);
  static const Duration animDurationFast = Duration(milliseconds: 175);

  ///
  /// [_settingsGrowController] is the animation controller responsible for the
  /// grow animation of the Settings icon that happens on page load
  /// The ..forward() method is called in [initState()]
  ///
  /// [_settingsGrowAnim] os the animation itself.
  /// It is a curved animation, from value 0.0 -> 24.0 with a bounceOut Curve
  ///
  /// These fields are initialized in the [initState()] function
  ///
  AnimationController _settingsGrowController;
  Animation _settingsGrowAnim;

  ///
  /// In exactly the same manner as the above pair (AnimationController, Animation),
  /// these 2 fields ([_searchGrowController],[_searchGrowAnim]) handle the grow
  /// effect applied onto the Search Icon.
  ///
  /// The expected behaviour is that if we navigate to a page that requires
  /// the search functionality from one that does not, then the search icon
  /// should grow ''into existence''
  /// If we navigate to a page that does not need the search functionality
  /// from one that does, then the search icon should shrink away
  ///
  /// Also note that this time, the animation uses a linear curve, not a bounce
  ///
  /// These fields are initialized in the [initState()] function
  ///
  AnimationController _searchGrowController;
  Animation _searchGrowAnim;

  ///
  /// [_settingsRotationController] is the animation controller responsible for
  /// the rotation performed by the settings icon whenever the tab is changed
  ///
  /// [_settingsAngle] is simply the current angle at which the icon is rendered
  /// This is achieved by wrapping the IconButton itself in a Transform.rotate(...)
  /// Note that due to the geometry of the icon, in order for it to appear in the
  /// 'normal' orientation, it must rotate in increments of 60 degrees. Otherwise,
  /// it will look crooked.
  ///
  /// The expected behaviour is that if we switched a number of tabs 'X' to the right
  /// then the icon should rotate with X * 60 degrees in that direction. Similarly,
  /// it would rotate -X * 60 degrees if we switched to a tab on the left.
  /// By jumping more tabs at once, we make the icon rotate more, but the duration
  /// of the animation doesn't change, so it will rotate faster, matching the
  /// animation of the pageView itself
  ///
  AnimationController _settingsRotationController;
  double _settingsAngle = 0.0;

  ///
  /// [_searchRotationController] is the animation controller responsible for
  /// the wiggle performed by the search icon
  ///
  /// [_searchAngle] is simply the current angle at which the icon is rendered
  /// This is achieved by wrapping the IconButton itself in a Transform.rotate(...)
  /// The icon will rock back and forth 25 degrees
  ///
  /// [_searchRotateDirection] basically handles in which direction the icon should
  /// wiggle, based on the scroll direction.
  /// It can be either 1 or -1, indicating whether it should go 25* up and down
  /// or down and up
  ///
  /// The expected behaviour is that if we switched to a tab that requires the
  /// search functionality from one that does so as well, then the search icon
  /// should do a little wiggle (a short rotation back and forth) in the direction
  /// in which we switched the tabs
  ///
  AnimationController _searchRotationController;
  double _searchAngle = 0.0;
  int _searchRotateDirection = 1;

  ///
  /// [_getActions] returns the list of widgets that is used as the actions fieeld
  /// in the appbar
  /// It contains the search button and the settings button
  /// They are both wrapped with Transform.rotate widgets as to allow the animations
  /// to happen
  ///
  List<Widget> _getActions() => [
        Transform.rotate(
          angle: _searchAngle,
          child: Hero(
            tag: "searchBtn",
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: double.parse(_searchGrowAnim.value.toString()),
                ),
                onPressed: () => _onSearchPressed(context),
              ),
            ),
          ),
        ),
        Transform.rotate(
            angle: _settingsAngle,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                size: double.parse(_settingsGrowAnim.value.toString()),
              ),
              onPressed: () => _onSettingsPressed(context),
            )),
      ];

  ///
  /// [_getBottomNavItems] returns a list of widgets extracted from the [_tabs]
  /// list. said list is used to populate the items field of the bottom navbar
  /// This function only extracts the icon associated with each tab via the
  /// .getIcon() accessor
  ///
  List<Widget> _getBottomNavItems() {
    final List<Widget> _items = [];
    for (int i = 0; i < _tabs.length; i++) {
      _items.add(Icon(_tabs[i].getIcon()));
    }
    return _items;
  }

  ///
  /// [_getPages] returns a list of widgets extracted from the [_tabs]
  /// list. said list is used to populate the children field of the page
  /// view.
  /// This function extracts the associated body of each tab via the
  /// .getBody() accessor
  /// The body of a tab is the UI itself
  ///
  List<Widget> _getPages() {
    final List<Widget> _items = [];
    for (int i = 0; i < _tabs.length; i++) {
      _items.add(_tabs[i].getBody());
    }
    return _items;
  }

  ///
  /// [_onSettingsPressed] gets called when the Settings Icon from the AppBar gets pressed
  /// It simply navigates back to the '/settings' route, loading an instance of SettingsPage
  ///
  void _onSettingsPressed(BuildContext context) {
    print("Pressed on Settings icon");
    Navigator.of(context).pushNamed('/settings');
  }

  ///
  /// [_onSearchPressed] gets called when the Search icon from the AppBar gets pressed
  /// It simply navigates back to the '/search' route, loading an instance of SearchPage
  ///
  void _onSearchPressed(BuildContext context) {
    print("Pressed on Search icon");
    Navigator.of(context).pushNamed('/search');
  }

  ///
  /// [_onBottomNavTap] gets called whenever an icon from the NavBar is pressed
  /// There is SOME logic performed here, such as:
  ///   - Rotating the Settings icon
  ///   - Wiggling the Search icon if necessary*
  ///   - Showing/Hiding the Search icon if necessary*
  ///   - Actually scrolling the pageView to the right tab
  ///   - Store the new current tab in [_currentTab]
  ///
  /// see the expected behaviour explained up top, near the declarations
  ///
  void _onBottomNavTap(int index) {
    // Rotate settings icon in increments of 60 * no_of_tabs_scrolled degrees
    _settingsRotationController =
        AnimationController(vsync: this, duration: animDurationSlow);
    final int _delta = index - _currentTab; // number of tabs jumped
    _settingsRotationController.addListener(() {
      setState(() {
        _settingsAngle =
            _settingsRotationController.value * _delta * 60 / 360 * 2 * 3.1415;
      });
    });
    _settingsRotationController.forward(); // animate

    switch (index) {
      case 1: // if we switched to projects tab
        if (_searchGrowAnim.status == AnimationStatus.dismissed) {
          _searchGrowController.forward();
        }
        if (_currentTab == 2) {
          _searchRotateDirection = -1; // change direction
          // note the forward.then => reverse, hence the rocking back and forth
          _searchRotationController
              .forward()
              .then((_) => _searchRotationController.reverse());
        }
        break;
      case 2: // if we switched to tasks tab
        if (_searchGrowAnim.status == AnimationStatus.dismissed) {
          _searchGrowController.forward();
        }
        if (_currentTab == 1) {
          _searchRotateDirection = 1; // change direction
          // note the forward.then => reverse, hence the rocking back and forth
          _searchRotationController
              .forward()
              .then((_) => _searchRotationController.reverse());
        }
        break;

      default: // if we switched to dashboard or account tab, hide both icons
        if (_searchGrowAnim.status == AnimationStatus.completed) {
          _searchGrowController.reverse();
        }
        break;
    }

    // Actually scroll to page
    _pageController.animateToPage(
      index,
      duration: animDurationSlow,
      curve: Curves.easeOut,
    );
    _currentTab = index; // update current tab
  }

  /// [initState] initializes the AnimationControllers and Animation fields
  @override
  void initState() {
    // Grow animation for Settigs icon
    _settingsGrowController = AnimationController(
      vsync: this,
      duration: animDurationSlow,
    )..addListener(() {
        setState(() {});
      });
    _settingsGrowAnim = Tween(begin: 0.0, end: 24.0).animate(CurvedAnimation(
      parent: _settingsGrowController,
      curve: Curves.bounceOut,
    ));
    _settingsGrowController.forward(); // Start animation on page load

    // Grow animation for Sorting icon
    _searchGrowController = AnimationController(
      vsync: this,
      duration: animDurationSlow,
    )..addListener(() {
        setState(() {});
      });
    _searchGrowAnim = Tween(begin: 0.0, end: 24.0).animate(
        CurvedAnimation(parent: _searchGrowController, curve: Curves.linear));

    // Rotation Animation for the Search Icon
    _searchRotationController =
        AnimationController(vsync: this, duration: animDurationFast);
    _searchRotationController.addListener(() {
      setState(() {
        _searchAngle = _searchRotationController.value *
            25 *
            _searchRotateDirection /
            360 *
            2 *
            3.1415;
      });
    });

    super.initState();
  }

  /// [dispose] makes sure to dispose of the AnimationControllers before leaving
  @override
  void dispose() {
    _settingsGrowController.dispose();
    _searchGrowController.dispose();
    _settingsRotationController.dispose();
    _searchRotationController.dispose();
    super.dispose();
  }

  ///
  /// [CONSTRUCTOR]: populates the [_tabs] list with the appropriate items
  ///
  _HomePageState() {
    _tabs.add(DashboardTab(
      projects: _getDummyProjects(),
      tasks: _getDummyTasks(),
    ));
    _tabs.add(ProjectsTab(_getDummyProjects()));
    _tabs.add(TasksTab(_getDummyTasks()));
    _tabs.add(const AccountTab());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_tabs[_currentTab].getName()), actions: _getActions()),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _getPages(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: _getBottomNavItems(),
        onTap: _onBottomNavTap,
        index: _currentTab,
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
        height: 50,
        animationDuration: animDurationSlow,
        animationCurve: Curves.linearToEaseOut,
      ),
    );
  }

  List<ProjectModel> _getDummyProjects() {
    final List<ProjectModel> projects = [];
    for (int i = 0; i < 50; i++) {
      projects.add(ProjectModel(
        id: i + 1,
        name: "Project ${i + 1}",
        description: "Description lorem ipsum",
        isPrivate: i % 19 == 7,
      ));
    }
    return projects;
  }

  List<TaskModel> _getDummyTasks() {
    final List<TaskModel> _tasks = [];
    for (int i = 0; i < 100; i++) {
      _tasks.add(TaskModel(
        name: "task ${i + 1}",
        description: "Description lorem ipsum",
        priority: i * 73 % 4,
      ));
    }
    return _tasks;
  }
}
