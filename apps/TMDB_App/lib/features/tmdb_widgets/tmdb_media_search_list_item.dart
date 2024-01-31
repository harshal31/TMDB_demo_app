import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';

class TmdbMediaSearchListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String imageUrl;
  final int index;
  final Function(int index)? onItemClick;

  const TmdbMediaSearchListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.imageUrl,
    required this.index,
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemClick?.call(index);
      },
      child: SizedBox(
        height: 141,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ExtendedImageCreator(
                imageUrl: imageUrl,
                width: 94,
                height: 141,
                borderRadius: BorderRadius.zero,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: context.textTheme.titleLarge),
                    Text(date, style: context.textTheme.titleMedium),
                    const SizedBox(height: 16),
                    Expanded(child: Text(subtitle, style: context.textTheme.titleSmall)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
