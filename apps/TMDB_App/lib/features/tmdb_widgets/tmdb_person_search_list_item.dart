import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';

class TmdbPersonSearchListItem extends StatelessWidget {
  final Persons? person;
  final int index;
  final Function(int index)? onItemClick;

  const TmdbPersonSearchListItem({
    super.key,
    this.person,
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
        height: 70,
        child: Row(
          children: [
            ExtendedImageCreator(
              imageUrl: person?.imageUrl ?? "",
              width: 94,
              height: 141,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(person?.name ?? "", style: context.textTheme.titleLarge),
                  const SizedBox(height: 2),
                  Expanded(
                    child: Text(
                      "Acting. ${person?.knownFor?.map((e) => e.title).join(", ")}",
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
