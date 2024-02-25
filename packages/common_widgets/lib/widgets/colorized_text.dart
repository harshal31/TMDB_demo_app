import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ColorizedText extends StatelessWidget {
  final String value;
  final TextStyle textStyle;

  const ColorizedText({super.key, required this.value, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.orange,
      Colors.white,
      Colors.green,
    ];

    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          value,
          textStyle: textStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
          colors: colorizeColors,
        ),
      ],
      isRepeatingAnimation: true,
    );
  }
}
