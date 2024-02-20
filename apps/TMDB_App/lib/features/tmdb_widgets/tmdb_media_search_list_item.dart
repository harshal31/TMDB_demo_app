import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';

class TmdbMediaSearchListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String imageUrl;
  final Function()? onItemClick;

  const TmdbMediaSearchListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.imageUrl,
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: context.colorTheme.onSurface.withOpacity(0.4), // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Border radius
      ),
      height: 141,
      margin: const EdgeInsets.only(bottom: 16),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExtendedImageCreator(
                imageUrl: imageUrl,
                width: 94,
                height: 141,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: title.isNotEmpty,
                        child: Column(
                          children: [
                            WrappedText(
                              title,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: date.isNotEmpty,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            WrappedText(
                              date.formatDateInMMMMFormat,
                              style: context.textTheme.titleSmall,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: subtitle.isNotEmpty,
                        child: WrappedText(
                          subtitle,
                          style: context.textTheme.titleSmall,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
