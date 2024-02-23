import 'package:common_widgets/gen/app_asset.dart';
import 'package:common_widgets/url_util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/constants/social_url_constants.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';

class TmdbShare extends StatelessWidget {
  final MediaExternalId? tmdbShareModel;
  final String mediaType;

  const TmdbShare({
    super.key,
    this.tmdbShareModel,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: tmdbShareModel?.isFidAvailable ?? false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    UrlUtil.launchInBrowser(
                      SocialUrlConstants.facebookUrl(tmdbShareModel?.facebookId),
                    );
                  },
                  icon: AppAsset.images.facebook.image(
                    package: "common_widgets",
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Visibility(
            visible: tmdbShareModel?.isInstaIdAvailable ?? false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    UrlUtil.launchInBrowser(
                      SocialUrlConstants.instaUrl(tmdbShareModel?.twitterId),
                    );
                  },
                  icon: AppAsset.images.instagram.image(
                    package: "common_widgets",
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Visibility(
            visible: tmdbShareModel?.isTwitIdAvailable ?? false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    UrlUtil.launchInBrowser(
                      SocialUrlConstants.twitterUrl(tmdbShareModel?.twitterId),
                    );
                  },
                  icon: AppAsset.images.twitter.image(
                    package: "common_widgets",
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Visibility(
            visible: tmdbShareModel?.isWikiIdAvailable ?? false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    UrlUtil.launchInBrowser(
                      SocialUrlConstants.wikiUrl(tmdbShareModel?.wikidataId),
                    );
                  },
                  icon: AppAsset.images.wiki.image(
                    package: "common_widgets",
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Visibility(
            visible: tmdbShareModel?.isImdbIdAvailable ?? false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    UrlUtil.launchInBrowser(
                      SocialUrlConstants.imdbUrl(tmdbShareModel?.imdbId, mediaType),
                    );
                  },
                  icon: AppAsset.images.imdb.image(
                    package: "common_widgets",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
