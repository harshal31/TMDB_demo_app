import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TmdbKeywordCompanySearchListItem extends StatelessWidget {
  final String name;
  final int index;
  final Function(int index)? onItemClick;

  const TmdbKeywordCompanySearchListItem({
    super.key,
    required this.name,
    required this.index,
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemClick?.call(index);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            Divider(
              color: context.colorTheme.onBackground.withOpacity(0.6),
              thickness: 2.0,
              height: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
