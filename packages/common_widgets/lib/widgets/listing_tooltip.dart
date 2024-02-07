import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ListingTooltip extends StatefulWidget {
  final String defaultSelectedItem;
  final List<String> items;
  final Function(String, int) onItemClick;

  const ListingTooltip({
    super.key,
    required this.items,
    required this.onItemClick,
    required this.defaultSelectedItem,
  });

  @override
  State<ListingTooltip> createState() => _ListingTooltipState();
}

class _ListingTooltipState extends State<ListingTooltip> {
  final SuperTooltipController _controller = SuperTooltipController();
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      controller: _controller,
      borderColor: context.colorTheme.onBackground.withOpacity(0.3),
      borderWidth: 1.0,
      hideTooltipOnTap: true,
      onShow: () {
        isShow = false;
      },
      onHide: () {
        isShow = true;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () {
            if (kIsWeb) {
              _controller.hideTooltip();
              return;
            }
            if (isShow) {
              _controller.showTooltip();
            } else {
              _controller.hideTooltip();
            }
          },
          onHover: (s) async {
            if (s) {
              _controller.showTooltip();
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.defaultSelectedItem,
                style: context.textTheme.titleMedium,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: context.colorTheme.onBackground,
              )
            ],
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int index = 0; index < widget.items.length; ++index)
            InkWell(
              onTap: () {
                _controller.hideTooltip();
                widget.onItemClick(
                  widget.items[index],
                  index,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.items[index],
                    style: context.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
