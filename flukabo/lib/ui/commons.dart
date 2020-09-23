import 'package:flutter/material.dart';

///
/// [showSnackbar] is self explanatory. It will display the given [content]
/// in a custom snackbar
///
void showSnackbar({
  @required BuildContext context,
  @required String content,
}) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

Widget buildInitial() => Container();
Widget buildLoading() => const Center(child: CircularProgressIndicator());
