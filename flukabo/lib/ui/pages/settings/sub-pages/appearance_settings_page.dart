import 'package:flukabo/bloc/theme/theme.dart';
import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// Template widget for theme showcase
///  A page with a custom background color and a text widget
/// on the bottom center:
///      +--------+
///      |        |
///      |        |
///      |        |
///      |        |
///      |  TEXT  |
///      |        |
///      +--------|
///
class ThemePage extends StatelessWidget {
  final String name;
  final Color background;
  const ThemePage({this.background, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Column(children: <Widget>[
        Expanded(flex: 4, child: Container()),
        Text(
          name,
          style: const TextStyle(
            letterSpacing: 2,
            fontSize: 24,
          ),
        ),
        Expanded(child: Container()),
      ]),
    );
  }
}

class AppearanceSettingsPage extends StatefulWidget {
  @override
  _AppearanceSettingsPageState createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState extends State<AppearanceSettingsPage>
    with TickerProviderStateMixin {
  ///
  /// [_pages] is a const list of widgets that constitute the contents of the pageView.
  /// The Pages are each meant to showcase one of the Themes (light/dark) and are of the
  /// [ThemePage] type (see above class)
  ///
  static const List<Widget> _pages = [
    ThemePage(name: "Dark Theme", background: Color.fromARGB(255, 48, 48, 48)),
    ThemePage(
        name: "Light Theme", background: Color.fromARGB(255, 255, 255, 255)),
  ];

  ///
  /// [_pageController] is the controller for the main pageView in the body
  /// This is used to handle jumping to the appropriate index in the pageView
  /// during theinitial loading
  /// The expected behaviour is that if this screen is entered while the active
  /// theme is of a dark variant, then the pageView would automatically jump to
  /// index 0 (since the first element in [_pages] is the dark theme showcase)
  /// And if the active theme is of the light variant, then the pageView should
  /// jump to index 1
  ///
  final PageController _pageController = PageController();

  ///
  /// [_isInitialized]: is true if the pageview has jumped to the right page
  /// according to the theme.
  /// This is taken into account in the pageView->onPageChanged method.
  /// If [_isInitialized] is false, the theme change event gets ignored
  /// Without this, the line _pageController.jumpToPage(...) from the constructor
  /// would trigger a theme change, and we don't want that.
  ///
  bool _isInitialized = false;

  ///
  /// [animationDuration] is a default duration for all the animations happening
  /// in this page.
  ///
  static const animationDuration = Duration(milliseconds: 350);

  ///
  /// [_rotationController] is the animation controller used to rotate the arrow
  /// at the bottom of the screen
  /// [_angle] the current angle at which the bottom arrow is rotated
  ///
  AnimationController _rotationController;
  double _angle = 0.0;

  ///
  /// [_onPageChanged] gets called each time the pageView page changes
  /// It makes sure that if the page finished initializing, the theme gets switched
  /// The arrow animation gets called either way so that if we load this page
  /// with a light theme, it has the correct initial orientation
  ///
  void _onPageChanged(BuildContext context) {
    if (_isInitialized) {
      context.bloc<ThemeBloc>().add(const ThemeSwitchEvent());
    }

    // Animate arrow
    if (_rotationController.status == AnimationStatus.completed) {
      _rotationController.reverse();
    }
    if (_rotationController.status == AnimationStatus.dismissed) {
      _rotationController.forward();
    }
    print("Page Changed");
  }

  ///
  /// [_onBackPressed] gets called when the back icon from the AppBar gets pressed
  /// It simply navigates back to the previous page
  ///
  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);

    print("Pressed the back icon");
  }

  ///
  /// The constructor initializes the shared preferences in order to get a
  /// hold of the active theme state (dark/light) and jump to the correct page
  /// in the pageview.
  /// Once all this is done, the variable [_isInitialized] is set to true
  /// as to allow the [_onPageChanged] method to actually do something
  /// After that, a quick initialization of the [_rotationController] is performed
  /// The listener makes sure the arrow rotates 180 degrees (2*pi/360)
  ///
  _AppearanceSettingsPageState() {
    Future.delayed(const Duration(milliseconds: 5)).then((value) {
      // automatically switch to the right page based on the current theme
      _pageController.jumpToPage(UserPreferences().isDarkTheme ? 0 : 1);
      _isInitialized = true;
    });

    // Initialize animation controller for bottom arrow
    _rotationController =
        AnimationController(vsync: this, duration: animationDuration);
    _rotationController.addListener(() {
      setState(() {
        _angle = 180 / 360 * 2 * 3.1415 * _rotationController.value;
      });
    });
  }

  ///
  /// In the body, the Stack is used to ovelay the pages from the PageView
  /// with an arrow icon, indicating the scroll direction for the theme switch
  /// to happen:
  ///
  ///      +--------+      +--------+
  ///      |        |      |        |
  ///      |        |      |        |
  ///      |        |      |        |
  ///      |        |      |        |
  ///      |  DARK  |      | LIGHT  |
  ///      |   >    |      |   <    |
  ///      +--------|      +--------|
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings / Appearance'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _onBackPressed(context),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            onPageChanged: (_) => _onPageChanged(context),
            controller: _pageController,
            children: _pages,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Transform.rotate(
                angle: _angle,
                child: Icon(
                  MdiIcons.arrowRightBold,
                  size: 48,
                  color: Theme.of(context).textTheme.bodyText2.color,
                )),
          ),
        ],
      ),
    );
  }
}
