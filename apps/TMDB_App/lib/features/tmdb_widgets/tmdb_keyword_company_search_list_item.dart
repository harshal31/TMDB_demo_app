import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';

class TmdbKeywordCompanySearchListItem extends StatelessWidget {
  final String name;
  final Function()? onItemClick;

  const TmdbKeywordCompanySearchListItem({
    super.key,
    required this.name,
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: context.colorTheme.onSurface.withOpacity(0.4), // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Border radius
      ),
      child: Card(
        margin: EdgeInsets.zero,
        surfaceTintColor: context.colorTheme.background,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            onItemClick?.call();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WrappedText(
                  name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
