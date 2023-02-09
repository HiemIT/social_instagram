import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onYesPressed;
  final VoidCallback? onNoPressed;

  ConfirmDialog({
    required this.title,
    required this.message,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? '',
      ),
      content: Text(message ?? ''),
      actions: <Widget>[
        TextButton(
          child: Text(
            "No",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onNoPressed,
        ),
        TextButton(
          child: Text(
            "Yes",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onYesPressed,
        ),
      ],
    );
  }
}
