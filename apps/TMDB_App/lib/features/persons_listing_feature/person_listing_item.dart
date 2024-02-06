import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';
import 'package:tmdb_app/routes/route_name.dart';

class PersonListingItem extends StatelessWidget {
  final Persons person;

  const PersonListingItem({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      surfaceTintColor: context.colorTheme.background,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: context.colorTheme.onBackground.withOpacity(0.4), // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 315,
              child: Stack(
                children: [
                  ExtendedImageCreator(
                    imageUrl: person.imageUrl,
                    width: double.infinity,
                    height: 315,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: InkWell(
                      splashColor: context.colorTheme.primary.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        context.push("${RouteName.home}/${RouteName.person}/${person.id}");
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  person.name ?? person.originalName ?? "",
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  person.knownForWork,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
