import 'package:flutter/material.dart';

void showSimpleSnackBar(BuildContext context, String message, {TextStyle? style}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: style,
      ),
    ),
  );
}
