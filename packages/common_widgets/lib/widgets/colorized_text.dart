import 'package:flutter/material.dart';

class ColorizedText extends StatelessWidget {
  final String value;
  final TextStyle textStyle;

  const ColorizedText({super.key, required this.value, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: textStyle.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    );
  }
}
