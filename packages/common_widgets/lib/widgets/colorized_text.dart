import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ColorizedText extends StatelessWidget {
  final String value;

  const ColorizedText({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    return SizedBox(
      width: 250.0,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            value,
            textStyle: context.textTheme.titleLarge!,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
      ),
    );
  }
}
