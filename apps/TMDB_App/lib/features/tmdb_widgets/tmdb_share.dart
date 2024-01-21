import 'package:common_widgets/gen/app_asset.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/url_util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/constants/social_url_constants.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';

class TmdbShare extends StatelessWidget {
  final MediaExternalId? tmdbShareModel;

  const TmdbShare({
    super.key,
    this.tmdbShareModel,
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
                  icon: ImageIcon(
                    AppAsset.images.facebook.provider(package: "common_widgets"),
                    size: 30,
                    color: context.colorTheme.primary,
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
                  icon: ImageIcon(
                    AppAsset.images.instagram.provider(package: "common_widgets"),
                    size: 30,
                    color: context.colorTheme.primary,
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
                  icon: ImageIcon(
                    AppAsset.images.twitter.provider(package: "common_widgets"),
                    size: 30,
                    color: context.colorTheme.primary,
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
                  icon: ImageIcon(
                    AppAsset.images.wiki.provider(package: "common_widgets"),
                    size: 30,
                    color: context.colorTheme.primary,
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
                      SocialUrlConstants.imdbUrl(tmdbShareModel?.imdbId),
                    );
                  },
                  icon: ImageIcon(
                    AppAsset.images.imdb.provider(package: "common_widgets"),
                    size: 30,
                    color: context.colorTheme.primary,
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
