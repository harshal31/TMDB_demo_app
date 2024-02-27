import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/code_utils.dart';
import 'package:common_widgets/widgets/dominant_color_from_image.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class PostersBackdropsListingScreenImpl extends StatelessWidget {
  final MediaDetail? mediaDetail;
  final String mediaType;
  final String mediaId;
  final bool isMovies;
  final bool isPosters;

  const PostersBackdropsListingScreenImpl({
    super.key,
    this.mediaDetail,
    required this.isMovies,
    required this.isPosters,
    required this.mediaType,
    required this.mediaId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BlocBuilder<CastCrewCubit, CastCrewState>(
            builder: (context, state) {
              return Visibility(
                visible: state.mediaDetail != null,
                child: SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DominantColorFromImage(
                          imageProvider: ExtendedImageCreator.getImage(
                            state.mediaDetail?.getBackdropImage() ?? "",
                          ).image,
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                ExtendedImageCreator(
                                  imageUrl: state.mediaDetail?.getPosterPath(),
                                  width: 58,
                                  height: 87,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: WrappedText(
                                    state.mediaDetail?.getMediaName(isMovies) ?? "",
                                    style: context.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SliverVisibility(
          visible: isPosters,
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<CastCrewCubit, CastCrewState>(
                builder: (context, state) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (state.mediaDetail?.images?.posters ?? []).length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: _calculateAspectRatio(context),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: _postersCrossAxisGridCount(context),
                      mainAxisExtent: isTabWeb(context) ? 450 : 250,
                    ),
                    itemBuilder: (ctx, index) {
                      final image = state.tmdbMediaState.posters
                          .map((e) => e.getOriginalImage())
                          .toList()[index];

                      return SizedBox(
                        height: isTabWeb(context) ? 450 : 260,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ExtendedImageCreator(
                                imageUrl: image,
                                height: isTabWeb(context) ? 450 : 260,
                                fit: BoxFit.fill,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned.fill(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  CommonNavigation.redirectToPosterBackdropScreen(
                                    context,
                                    mediaDetail,
                                    mediaId,
                                    mediaType,
                                    isPosters,
                                    index: index,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          replacementSliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<CastCrewCubit, CastCrewState>(
                builder: (context, state) {
                  return isTabWeb(context)
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (state.mediaDetail?.images?.backdrops ?? []).length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: _calculateAspectRatio(context),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            crossAxisCount: _getCrossAxisGridCount(context),
                            mainAxisExtent: 400,
                          ),
                          itemBuilder: (ctx, index) {
                            final image = state.tmdbMediaState.backdrops
                                .map((e) => e.getImage())
                                .toList()[index];

                            return SizedBox(
                              height: 400,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ExtendedImageCreator(
                                      imageUrl: image,
                                      height: 400,
                                      fit: BoxFit.fill,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        CommonNavigation.redirectToPosterBackdropScreen(
                                          context,
                                          mediaDetail,
                                          mediaId,
                                          mediaType,
                                          isPosters,
                                          index: index,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (state.mediaDetail?.images?.backdrops ?? []).length,
                          separatorBuilder: (ctx, index) => const SizedBox(height: 16),
                          itemBuilder: (ctx, index) {
                            final image = state.tmdbMediaState.backdrops
                                .map((e) => e.getImage())
                                .toList()[index];

                            return SizedBox(
                              height: 220,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ExtendedImageCreator(
                                      width: double.infinity,
                                      imageUrl: image,
                                      height: 220,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        CommonNavigation.redirectToPosterBackdropScreen(
                                          context,
                                          mediaDetail,
                                          mediaId,
                                          mediaType,
                                          isPosters,
                                          index: index,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  int _getCrossAxisGridCount(BuildContext context) {
    return 2;
  }

  int _postersCrossAxisGridCount(BuildContext context) {
    return isTabWeb(context) ? 4 : 2;
  }

  double _calculateAspectRatio(BuildContext context) {
    return MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
  }
}
