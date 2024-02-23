import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TmdbSearchWidget extends StatefulWidget {
  final Function(String) onSearch;
  final String? query;

  const TmdbSearchWidget({
    super.key,
    required this.onSearch,
    this.query,
  });

  @override
  State<TmdbSearchWidget> createState() => _TmdbSearchWidgetState();
}

class _TmdbSearchWidgetState extends State<TmdbSearchWidget> {
  late final TextEditingController controller = TextEditingController(text: widget.query ?? "");
  final FocusNode focusNode = FocusNode();
  bool isDisplaySearchIcon = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            onSubmitted: (s) {
              widget.onSearch(s);
            },
            onChanged: (s) {
              setState(() {
                isDisplaySearchIcon = s.isNotEmpty;
              });
            },
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.colorTheme.primary,
                  width: 2.0,
                ),
              ),
              suffixIcon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isDisplaySearchIcon
                    ? Padding(
                        key: ValueKey(isDisplaySearchIcon),
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          onPressed: () {
                            controller.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isDisplaySearchIcon = false;
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                      )
                    : SizedBox.shrink(
                        key: ValueKey(isDisplaySearchIcon),
                      ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: context.tr.searchFor,
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: isDisplaySearchIcon
              ? Row(
                  key: ValueKey(isDisplaySearchIcon),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 8),
                    IconButton.outlined(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        widget.onSearch(controller.text);
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isDisplaySearchIcon = false;
                        });
                      },
                    ),
                  ],
                )
              : SizedBox.shrink(
                  key: ValueKey(isDisplaySearchIcon),
                ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    controller.clear();
  }
}
