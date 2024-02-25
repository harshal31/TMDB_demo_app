import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/colorized_text.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
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
        child: SizedBox(
          width: double.infinity,
          height: kIsWeb ? 450 : 250,
          child: Stack(
            children: [
              Positioned.fill(
                child: ExtendedImageCreator(
                  imageUrl: person.imageUrl,
                  width: double.infinity,
                  height: kIsWeb ? 450 : 250,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: ColorizedText(
                    value: (person.name ?? person.originalName ?? "").split(" ").firstOrNull ?? "",
                    textStyle: kIsWeb
                        ? context.textTheme.displayLarge!
                        : context.textTheme.headlineMedium!,
                  ),
                ),
              ),
              Positioned.fill(
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    context.push("${RouteName.home}/${RouteName.person}/${person.id}");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
