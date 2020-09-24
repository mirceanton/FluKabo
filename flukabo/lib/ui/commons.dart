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

Widget buildError(
  BuildContext context, {
  @required IconData icon,
  @required String message,
  void Function() onButtonPress,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, size: 128.0),
      const SizedBox(height: 16.0),
      Text(message, style: const TextStyle(letterSpacing: 1.25)),
      const SizedBox(height: 16.0),
      OutlineButton(
        onPressed: () => onButtonPress,
        child: const Text('Retry', style: TextStyle(letterSpacing: 1.15)),
      ),
    ],
  );
}
