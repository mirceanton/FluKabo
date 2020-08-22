import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

///
/// A template widget for the custom list items used for the settings items
/// This is simply put a clickable ListTile
/// This has been achieved by wrapping the ListTile Widget in a transparent
/// Material Widget and in an InkWell
///
/// The ListTile has a title, subtitle and a leading icon with the accent color
/// applied and a preset size of 32
///
/// [onTap] is the function called when the InkWell receives a tap event
/// [leading] is the IconData for the leading icon
/// [title] and [subtitle] are self explanatory. Note that they
/// are only strings, not Text Widgets
///
class SettingsItem extends StatelessWidget {
  final Function() onTap;
  final IconData leading;
  final String title, subtitle;

  const SettingsItem({
    @required this.onTap,
    @required this.leading,
    @required this.title,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(
                  leading,
                  size: 32,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(title),
                subtitle: Text(subtitle))));
  }
}

class SettingsPage extends StatelessWidget {
  ///
  /// [_onBackPressed] is called when the back icon from the AppBar is clicked
  /// It simply navigates back to the previous page
  ///
  void _onBackPressed(BuildContext context) {
    print('Pressed back button');
    Navigator.pop(context);
  }

  ///
  /// [_onServerSettingsPressed] is called when the ConnectionSettings item is
  /// clicked.
  /// It navigates to the route '/settings/server'
  ///
  void _onServerSettingsPressed(BuildContext context) {
    print('Pressed on Server Settings');
    Navigator.pushNamed(context, '/settings/server');
  }

  ///
  /// [_onAppearanceSettingsPressed] is called when the AppearanceSettings item
  /// is clicked.
  /// It navigates to the route '/setitngs/appearance'
  ///
  void _onAppearanceSettingsPressed(BuildContext context) {
    print('Pressed on Appearance Settings');
    Navigator.pushNamed(context, '/settings/appearance');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _onBackPressed(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SettingsItem(
              title: 'Connection Settings',
              subtitle:
                  'Set the adress of you Kanboard server as well as your credentials',
              leading: MdiIcons.transitConnectionVariant,
              onTap: () => _onServerSettingsPressed(context),
            ),
            SettingsItem(
              title: 'Appearance Settings',
              subtitle: 'Set the color theme',
              leading: MdiIcons.selectColor,
              onTap: () => _onAppearanceSettingsPressed(context),
            ),
          ],
        ),
      ),
    );
  }
}
