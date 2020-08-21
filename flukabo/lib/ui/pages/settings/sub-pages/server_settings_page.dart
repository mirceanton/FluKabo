import 'package:flukabo/bloc/auth/auth_bloc.dart';
import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

///
/// A template class that is used to generate the fields via Lists
/// [labels] -> list of strings containing the labels (hints) for each text field
/// [controllers] -> list of TextEditingControllers, one for each field
/// ! there will be as many fields as elements in these list. they have to be of
/// ! the same length, or you will encounter errors
/// [title] -> the title of the category
/// [icon] -> an icon representing the category
/// The title and the icon both have a custom [color] applied to them
/// +---------------------------------+
/// |   @ TITLE                       |
/// |                                 |
/// |  ==FIELD======================  |
/// |  ==FIELD=====================   |
/// |  ...                            |
/// |  ==FIELD=====================   |
/// +---------------------------------+
///
/// Preset values will be set via the controllers, once the preferences are getting
/// loaded.
///
class CategoryTile extends StatelessWidget {
  final List<String> labels;
  final List<TextEditingController> controllers;
  final String title;
  final IconData icon;
  final Color color;

  const CategoryTile({
    @required this.labels,
    @required this.controllers,
    @required this.title,
    @required this.icon,
    @required this.color,
  });

  ///
  /// [_buildFields] takes the Lists provided in the constructor, and uses them
  /// to generate TextFormFields, and wraps them in a Column, with a SizedBox as
  /// a separator.
  /// [labels] is used to set the labelText property for each field
  /// [controllers] is used to get the TextEditingController for each field
  ///
  Widget buildFields() {
    final List<Widget> fields = [];

    for (int i = 0; i < labels.length; i++) {
      fields.add(
        TextFormField(
          decoration: InputDecoration(labelText: labels[i]),
          cursorWidth: 0.75,
          controller: controllers[i],
        ),
      );

      if (i < labels.length - 1) {
        fields.add(const SizedBox(height: 8.0));
      }
    }

    return Column(children: fields);
  }

  ///
  /// [buildTitle] takes the [icon] and the [title] and arranges them in a similar
  /// fashion to the ListTile layout, with a custom [color] on both of them
  ///
  Widget buildTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0), // Server Settings
        child: Column(children: <Widget>[
          buildTitle(),
          buildFields(),
        ]));
  }
}

class ServerSettingsPage extends StatefulWidget {
  @override
  _ServerSettingsPageState createState() => _ServerSettingsPageState();
}

class _ServerSettingsPageState extends State<ServerSettingsPage> {
  ///
  /// [_allowCerts] is true if all SSL certificates are allowed, ignoring
  /// handshake errors.
  ///
  /// This field holds the value represented by the UI, as in the check/uncheck
  /// status of the checkbox, not the one from Shared Preferences.
  /// Once the Save Button is clicked, this gets written to the preferences and
  /// cached.
  ///
  bool _allowCerts = false;

  ///
  /// [*Controller] are all the TextEditingControllers associated to the appropriately
  /// named TextFormField.
  /// These are used for 2 main purposes:
  ///   1. Once the Shared Preferences are loaded, these are used to push the
  ///       already existing data to the text fields, acting as placeholder data
  ///   2. Once the Save Button is pressed, these are used to get the new data
  ///       out of the TextFormFields and into variables via *Controller.text
  ///
  final TextEditingController _baseUrlController = TextEditingController(),
      _portController = TextEditingController(),
      _apiController = TextEditingController(),
      _userController = TextEditingController(),
      _tokenController = TextEditingController();

  String _getURL({
    @required String base,
    @required String port,
    @required String apiPath,
  }) =>
      '$base:$port/$apiPath';

  ///
  /// [_save] gets called whenever the 'Save' button from the AppBar is pressed
  /// It simply sends an AuthEvent to the AuthBLoC
  ///
  void _save() {
    context.bloc<AuthBloc>().add(AuthEvent(
          url: _getURL(
            base: _baseUrlController.text.trim(),
            port: _portController.text.trim(),
            apiPath: _apiController.text.trim(),
          ),
          username: _userController.text.trim(),
          token: _tokenController.text.trim(),
          acceptAllCerts: _allowCerts,
        ));
    print("Pressed the save button");
  }

  ///
  /// [_changeSecurityLevel] is called when the SSL Certificate List Tile is
  /// clicked, acting as a way to make the clickable area of the 'checkbox' as
  /// big as the list tile itself.
  /// This simply cahnges the _allowCerts to be negated, and calls setState to
  /// update the 'checkbox'
  ///
  void _changeSecurityLevel() {
    _allowCerts = !_allowCerts;
    setState(() {}); // to update the checkbox check status
  }

  ///
  /// [_onBackPressed] gets called when the back icon from the AppBar gets pressed
  /// It simply navigates back to the previous page
  ///
  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);

    print("Pressed the back icon");
  }

  // TODO document me
  void _updatePreferences() {
    UserPreferences().baseUrl = _baseUrlController.text;
    UserPreferences().port = _portController.text;
    UserPreferences().api = _apiController.text;
    UserPreferences().acceptAllCerts = _allowCerts;
    UserPreferences().userName = _userController.text;
    UserPreferences().token = _tokenController.text;
  }

  void _showSnack({
    @required BuildContext buildContext,
    @required String message,
  }) {
    Scaffold.of(buildContext).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  // TODO document me
  Widget _builder(BuildContext context, AuthState state) {
    switch (state.runtimeType) {
      case AuthLoadingState:
        return buildLoading(context);
      case AuthSuccessState:
        return buildSuccess(context);
      case AuthErrorState:
        return buildError(context);
      default:
        return buildInitial(context);
    }
  }

  // TODO document me
  void _listener(BuildContext context, AuthState state) {
    if (state is AuthErrorState) {
      print('Error STATE');
      _showSnack(buildContext: context, message: state.errmsg);
    } else if (state is AuthSuccessState) {
      _updatePreferences();
      _showSnack(buildContext: context, message: 'Preferences Updated');
    }
  }

  ///
  /// [CONSTRUCTOR]
  /// The constructor waits for the Preferences Manager to initialize, then
  /// retrieves the appropriate data and pushes it to the text controllers,
  /// updating the on-screen text
  ///
  _ServerSettingsPageState() {
    _baseUrlController.text = UserPreferences().baseUrl;
    _portController.text = UserPreferences().port;
    _apiController.text = UserPreferences().api;
    _userController.text = UserPreferences().userName;
    _tokenController.text = UserPreferences().token;
    _allowCerts = UserPreferences().acceptAllCerts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Connection'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _onBackPressed(context),
          ),
          actions: [
            FlatButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
            const SizedBox(width: 8.0),
          ]),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  // TODO document me
  Widget buildError(BuildContext context) =>
      buildMainUI(buildContext: context, color: Colors.redAccent);

  // TODO document me
  Widget buildSuccess(BuildContext context) =>
      buildMainUI(buildContext: context, color: Colors.greenAccent);

  // TODO document me
  Widget buildInitial(BuildContext context) =>
      buildMainUI(buildContext: context, color: Theme.of(context).accentColor);

  // TODO document me
  Widget buildMainUI({BuildContext buildContext, Color color}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CategoryTile(
            title: 'Server Settings',
            icon: MdiIcons.server,
            color: color,
            labels: const ['Base URL', 'Port', 'Api Path'],
            controllers: [_baseUrlController, _portController, _apiController],
          ),
          const Divider(),
          CategoryTile(
            title: 'Authentication',
            icon: MdiIcons.accountLock,
            color: color,
            labels: const ['Username', 'Token'],
            controllers: [_userController, _tokenController],
          ),
          const Divider(),
          CategoryTile(
            title: 'Security',
            icon: MdiIcons.security,
            color: color,
            labels: const [],
            controllers: const [],
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 16.0, right: 32.0),
            onTap: _changeSecurityLevel,
            title: const Text("Allow self-signed certificates"),
            subtitle: const Text(
              "Trust ALL certificates, even if the TLS handshake has failed.",
            ),
            trailing: Icon(
              _allowCerts ? Icons.check_box : Icons.check_box_outline_blank,
              size: 32,
            ),
          )
        ],
      ),
    );
  }

  // TODO document me
  Widget buildLoading(BuildContext context) {
    return Stack(
      children: [
        buildMainUI(
          buildContext: context,
          color: Theme.of(context).accentColor,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black87,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
