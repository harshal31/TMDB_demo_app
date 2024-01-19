import 'package:common_widgets/gen/app_asset.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/url_util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/constants/social_url_constants.dart';

class TmdbShare extends StatelessWidget {
  final TmdbShareModel? tmdbShareModel;

  const TmdbShare({
    super.key,
    this.tmdbShareModel,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
              visible: tmdbShareModel?.isFidAvailable ?? false,
              child: IconButton(
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
            ),
            const SizedBox(width: 16),
            Visibility(
              visible: tmdbShareModel?.isInstaIdAvailable ?? false,
              child: IconButton(
                onPressed: () {
                  UrlUtil.launchInBrowser(
                    SocialUrlConstants.instaUrl(tmdbShareModel?.instaId),
                  );
                },
                icon: ImageIcon(
                  AppAsset.images.instagram.provider(package: "common_widgets"),
                  size: 30,
                  color: context.colorTheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Visibility(
              visible: tmdbShareModel?.isTwitIdAvailable ?? false,
              child: IconButton(
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
            ),
            const SizedBox(width: 16),
            Visibility(
              visible: tmdbShareModel?.isWikiIdAvailable ?? false,
              child: IconButton(
                onPressed: () {
                  UrlUtil.launchInBrowser(
                    SocialUrlConstants.wikiUrl(tmdbShareModel?.wikiId),
                  );
                },
                icon: ImageIcon(
                  AppAsset.images.wiki.provider(package: "common_widgets"),
                  size: 30,
                  color: context.colorTheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Visibility(
              visible: tmdbShareModel?.isImdbIdAvailable ?? false,
              child: IconButton(
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
            ),
          ],
        ),
      ),
    );
  }
}

class TmdbShareModel {
  final String? imdbId;
  final String? wikiId;
  final String? facebookId;
  final String? instaId;
  final String? twitterId;

  TmdbShareModel({
    this.imdbId,
    this.wikiId,
    this.facebookId,
    this.instaId,
    this.twitterId,
  });

  bool get isFidAvailable {
    return facebookId?.isNotEmpty ?? false;
  }

  bool get isInstaIdAvailable {
    return instaId?.isNotEmpty ?? false;
  }

  bool get isTwitIdAvailable {
    return twitterId?.isNotEmpty ?? false;
  }

  bool get isWikiIdAvailable {
    return wikiId?.isNotEmpty ?? false;
  }

  bool get isImdbIdAvailable {
    return imdbId?.isNotEmpty ?? false;
  }
}
