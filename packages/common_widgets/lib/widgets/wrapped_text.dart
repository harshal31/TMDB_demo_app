import 'package:flutter/material.dart';

/// Top level text widget throughout the project we need to use this
/// [WrappedText] instead [Text] widget.
class WrappedText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  const WrappedText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: style,
      maxLines: maxLines,
      overflow: TextOverflow.fade,
      softWrap: true,
      textAlign: textAlign,
    );
  }
}
