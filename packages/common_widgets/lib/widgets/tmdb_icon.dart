import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TmdbIcon extends StatefulWidget {
  final (IconData, IconData) icons;
  final Color selectedColor;
  final double? iconSize;
  final bool isSelected;
  final Function(bool)? onSelection;
  final String? hoverMessage;

  const TmdbIcon({
    super.key,
    required this.icons,
    required this.isSelected,
    this.onSelection,
    this.iconSize,
    required this.selectedColor,
    this.hoverMessage,
  });

  @override
  State<TmdbIcon> createState() => _TmdbIconState();
}

class _TmdbIconState extends State<TmdbIcon> {
  bool selection = false;

  @override
  void initState() {
    super.initState();
    selection = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: BoxDecoration(color: context.colorTheme.background),
      textStyle: context.textTheme.titleMedium,
      message: widget.hoverMessage ?? "",
      child: GestureDetector(
        onTap: () {
          setState(() {
            selection = !selection;
            widget.onSelection?.call(selection);
          });
        },
        child: Material(
          color: context.colorTheme.background,
          shape: const CircleBorder(),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              selection ? widget.icons.$1 : widget.icons.$2,
              size: widget.iconSize,
              color: selection ? widget.selectedColor : context.colorTheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}
