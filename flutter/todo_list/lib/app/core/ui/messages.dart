import 'package:flutter/material.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void showError(String message) =>
      _showMessage(message: message, color: Colors.red);
  void showWarning(String message) => _showMessage(
      message: message,
      color: Colors.yellow,
      textStyle: const TextStyle(
        color: Colors.black,
      ));
  void showInfo(String message) =>
      _showMessage(message: message, color: Colors.green);

  void _showMessage({required message, required color, TextStyle? textStyle}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle,
        ),
        backgroundColor: color,
      ),
    );
  }
}
