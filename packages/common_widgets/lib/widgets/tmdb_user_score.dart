import 'dart:math';

import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';

class TmdbUserScore extends StatelessWidget {
  final double average;
  final int? voteCount;
  final double? circleSize;
  final Color? color;
  final TextStyle? style;
  final TextStyle? numberStyle;

  const TmdbUserScore({
    super.key,
    required this.average,
    required this.voteCount,
    this.circleSize,
    this.color,
    this.style,
    this.numberStyle,
  });

  @override
  Widget build(BuildContext context) {
    final avg = roundToNearestDecimal(average, 1) / 10;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: circleSize,
          height: circleSize,
          child: Stack(
            children: [
              Positioned.fill(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: avg),
                  duration: const Duration(seconds: 1),
                  builder: (BuildContext context, double value, Widget? child) {
                    return CircleAvatar(
                      radius: circleSize,
                      child: SizedBox(
                        width: circleSize,
                        height: circleSize,
                        child: CircularProgressIndicator(
                          strokeWidth: 5.0,
                          value: value,
                          color: color ?? context.colorTheme.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Visibility(
                  visible: average != 0.0,
                  child: WrappedText(
                    "${(avg * 100).toInt()}%",
                    style: numberStyle?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  replacement: WrappedText(
                    "-",
                    style: numberStyle?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            WrappedText(
              context.tr.userScore,
              style: style?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            Visibility(
              visible: voteCount != 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 2),
                  WrappedText(
                    "(${context.tr.totalVotes(voteCount ?? 0)})",
                    style: context.textTheme.titleSmall,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  double roundToNearestDecimal(double value, int decimalPlaces) {
    double fraction = pow(10, decimalPlaces).toDouble();
    return (value * fraction).round() / fraction;
  }
}
