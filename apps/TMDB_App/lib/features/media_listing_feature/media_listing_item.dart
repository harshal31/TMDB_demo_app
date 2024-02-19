import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class MediaListingItem extends StatelessWidget {
  final LatestData latestData;
  final bool isMovies;

  const MediaListingItem({
    super.key,
    required this.latestData,
    required this.isMovies,
  });

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
        height: 400,
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
          height: 400,
          child: Stack(
            children: [
              ExtendedImageCreator(
                imageUrl: latestData.getImagePath(),
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: context.colorTheme.primary.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      CommonNavigation.redirectToDetailScreen(
                        context,
                        mediaType: (isMovies ? ApiKey.movie : ApiKey.tv),
                        mediaId: latestData.id.toString(),
                      );
                    },
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
