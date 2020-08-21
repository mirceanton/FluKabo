import 'package:flutter/material.dart';

///
/// A custom TextFormField Widget with all the border decorations removed
///
/// [hint] is the prompt text shown in the field before any editing has happened
///
/// [search] is the function that gets called when the focus is lost
///
/// [onTextChanged] is self explanatory. It gets called when the text
/// inside the TextFormField has changed
///
class EditText extends StatelessWidget {
  final String hint;
  final void Function() search;
  final void Function(String) onTextChanged;

  const EditText({
    @required this.hint,
    @required this.search,
    @required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      cursorWidth: 0.75,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hint,
      ),
      onChanged: onTextChanged,
      onEditingComplete: search,
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _needle = ''; // holds the search term given by the user

  // ignore: use_setters_to_change_properties
  ///
  /// [_onSearchTextChanged] is the function that gets passed through to the
  /// onTextChanged field in the EditText.
  /// This function gets called when any change has been made to the contents
  /// of the EditText Widget
  /// It simply updates [_needle], much like a TextController would work
  ///
  void _onSearchTextChanged(String text) => _needle = text;

  ///
  /// [_search] is the function that actually performs the searching logic
  /// This gets called when the text editing has finished, or when the search
  /// icon in the appbar is clicked
  ///
  void _search(BuildContext context) {
    FocusScope.of(context).unfocus(); // hide the keyboard
    // TODO SEARCH

    // DEBUG
    print('Start performing search with: $_needle');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: EditText(
          hint: 'Search...',
          onTextChanged: _onSearchTextChanged,
          search: () => _search(context),
        ),
        actions: [
          Hero(
            tag: 'searchBtn',
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                  icon: const Icon(Icons.search, size: 24),
                  onPressed: () => _search(context)),
            ),
          ),
        ],
      ),

      body: Container(), // TODO
    );
  }
}
