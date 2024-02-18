import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/dominant_color_from_image.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/tmdb_pop_menu.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/app_constant.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/tmdb_media_feature/screens/video_listing_screen/screens/desktop_tab/tmdb_video_listing.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';

class TmdbYoutubeMediaListingMobileImpl extends StatelessWidget {
  final bool isMovies;
  final String mediaId;

  const TmdbYoutubeMediaListingMobileImpl({
    super.key,
    required this.isMovies,
    required this.mediaId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastCrewCubit, CastCrewState>(
      builder: (context, state) {
        if (state.castCrewStatus is CastCrewLoading || state.castCrewStatus is CastCrewNone) {
          return const Center(
            child: LottieLoader(),
          );
        }

        if (state.castCrewStatus is CastCrewError) {
          return Center(
            child: Text(
              (state.castCrewStatus as CastCrewError).error,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverVisibility(
              visible: state.mediaDetail != null,
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DominantColorFromImage(
                          imageProvider: ExtendedNetworkImageProvider(
                            state.mediaDetail?.getBackdropImage() ?? "",
                            cache: true,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                ExtendedImageCreator(
                                  imageUrl: state.mediaDetail?.getPosterPath() ?? "",
                                  width: 58,
                                  height: 87,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    state.mediaDetail?.getMediaName(isMovies) ?? "",
                                    style: context.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TmdbPopMenu(
                                  iconSize: 20,
                                  iconData: Icons.sort,
                                  menus: [
                                    PopMenuData(name: AppConstant.all),
                                    ...state.tmdbMediaState.groupVideos.groupVideos.keys
                                        .map((e) => PopMenuData(name: e))
                                        .toList(),
                                  ],
                                  onSelectedItem: (index, item) {
                                    context.read<CastCrewCubit>().filterDataBasedOnType(
                                          CastCrewType.videos,
                                          item,
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TmdbYoutubeVideoList(
                  tmdbState: state,
                  isMovies: isMovies,
                  mediaId: mediaId,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class TmdbYoutubeVideoList extends StatelessWidget {
  final CastCrewState tmdbState;
  final bool isMovies;
  final String mediaId;

  const TmdbYoutubeVideoList({
    super.key,
    required this.tmdbState,
    required this.isMovies,
    required this.mediaId,
  });

  @override
  Widget build(BuildContext context) {
    if (tmdbState.tmdbMediaState.tmdbMediaStatus is TmdbNoDataPresent) {
      return Center(
        child: Text(
          context.tr.noDataPresentForType(
            tmdbState.mediaDetail?.getMediaName(isMovies) ?? "",
            tmdbState.tmdbMediaState.currentPopupState,
          ),
          style: context.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      );
    }

    return AnimatedOpacity(
      opacity: (tmdbState.tmdbMediaState.tmdbMediaStatus is TmdbFilterDone) ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
      child: TmdbVideosListing(
        map: tmdbState.tmdbMediaState.groupVideos.currentGroupVideos.isEmpty
            ? tmdbState.tmdbMediaState.groupVideos.groupVideos
            : tmdbState.tmdbMediaState.groupVideos.currentGroupVideos,
        imageWidth: 150,
        imageHeight: 150,
        mediaId: mediaId,
        isMovies: isMovies,
      ),
    );
  }
}
