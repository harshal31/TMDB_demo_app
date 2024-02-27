import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/dominant_color_from_image.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/screens/cast_crew_list_item.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';

class CastCrewMobileScreen extends StatelessWidget {
  final bool isMovies;

  const CastCrewMobileScreen({
    super.key,
    required this.isMovies,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastCrewCubit, CastCrewState>(
      builder: (context, state) {
        if (state.castCrewStatus is CastCrewLoading || state.castCrewStatus is CastCrewNone) {
          return const LinearLoader();
        }

        if (state.castCrewStatus is CastCrewError) {
          return Center(
            child: WrappedText(
              (state.castCrewStatus as CastCrewError).error,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }
        final casts = state.mediaDetail?.credits?.cast ?? [];
        final crews = state.mediaDetail?.credits?.crew ?? [];
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
                          padding: const EdgeInsets.only(left: 16.0),
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
              ),
            ),
            SliverVisibility(
              visible: casts.isNotEmpty,
              sliver: SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WrappedText(
                        numberCastValue(context, state),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: casts.length,
                        itemBuilder: (ctx, index) {
                          return CastCrewListItem(
                            key: ValueKey(index),
                            imageUrl: casts[index].getImage(),
                            title: casts[index].name ?? casts[index].originalName ?? "",
                            subtitle: casts[index].character ?? "",
                            id: casts[index].id.toString(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverVisibility(
              visible: crews.isNotEmpty,
              sliver: SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WrappedText(
                        numberCrewValue(context, state),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.groupCrew.length,
                        itemBuilder: (ctx, index) {
                          final values =
                              state.groupCrew[state.groupCrew.keys.toList()[index]] ?? [];
                          return Column(
                            key: ValueKey(index),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WrappedText(
                                state.groupCrew.keys.toList()[index],
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: values.length,
                                itemBuilder: (ctx, index) {
                                  return CastCrewListItem(
                                    key: ValueKey(index),
                                    imageUrl: values[index].getImage(),
                                    title: values[index].name ?? casts[index].originalName ?? "",
                                    subtitle: values[index].job ?? "",
                                    id: values[index].id.toString(),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String numberCastValue(BuildContext context, CastCrewState state) {
    return isMovies
        ? context.tr.castNumber(state.mediaDetail?.credits?.cast?.length.toString() ?? "")
        : context.tr.seriesCastNumber(state.mediaDetail?.credits?.cast?.length.toString() ?? "");
  }

  String numberCrewValue(BuildContext context, CastCrewState state) {
    return isMovies
        ? context.tr.crewNumber(state.mediaDetail?.credits?.crew?.length.toString() ?? "")
        : context.tr.seriesCrewNumber(state.mediaDetail?.credits?.crew?.length.toString() ?? "");
  }
}
