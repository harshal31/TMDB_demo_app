import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/theme_util.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';

class TmdbPersonSearchListItem extends StatelessWidget {
  final Persons? person;
  final Function()? onItemClick;

  const TmdbPersonSearchListItem({
    super.key,
    this.person,
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
      height: 90,
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
            children: [
              ExtendedImageCreator(
                imageUrl: person?.imageUrl ?? "",
                fit: BoxFit.cover,
                width: 70,
                height: 90,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WrappedText(
                      person?.name ?? "",
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 2),
                    WrappedText(
                      context.tr.actionFor(
                        person?.knownForDepartment ?? "",
                        person?.knownFor?.map((e) => e.title).join(", ") ?? "",
                      ),
                      style: context.textTheme.titleSmall,
                      maxLines: 1,
                    ),
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
