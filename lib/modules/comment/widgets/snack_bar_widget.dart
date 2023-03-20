import 'package:flutter/material.dart';

enum IconType { success, error }

class SnackBarWidget extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final IconType iconType;

  const SnackBarWidget({
    Key? key,
    this.iconType = IconType.error,
    required this.message,
    this.backgroundColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconType == IconType.error
              ? Icon(
                  Icons.error,
                  color: Colors.white,
                )
              : Icon(
                  Icons.check,
                  color: Colors.white,
                ),
        ],
      ),
    );
  }
}
