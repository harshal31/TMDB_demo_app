import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:tmdb_app/routes/route_name.dart';

class CastCrewListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String id;

  const CastCrewListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          context.push(
            Uri(
              path: "${RouteName.home}/${RouteName.person}/$id",
            ).toString(),
          );
        },
        child: Row(
          children: [
            ExtendedImageCreator(
              imageUrl: imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  WrappedText(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  WrappedText(
                    subtitle,
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
