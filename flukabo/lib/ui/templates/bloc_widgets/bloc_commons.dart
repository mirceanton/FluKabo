import 'package:flutter/material.dart';

class InitialBlocWidget extends StatelessWidget {
  const InitialBlocWidget();
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class LoadingBlocWidget extends StatelessWidget {
  final String message;
  const LoadingBlocWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16.0),
        Text(
          "$message...",
          style: const TextStyle(letterSpacing: 1.15),
        ),
      ],
    );
  }
}

class ErrorBlocWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final void Function(BuildContext) callback;

  const ErrorBlocWidget({
    @required this.callback,
    @required this.icon,
    @required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 128.0),
        const SizedBox(height: 16.0),
        Text(message, style: const TextStyle(letterSpacing: 1.25)),
        const SizedBox(height: 16.0),
        OutlineButton(
          onPressed: () => callback(context),
          child: const Text('Retry', style: TextStyle(letterSpacing: 1.15)),
        ),
      ],
    );
  }
}
