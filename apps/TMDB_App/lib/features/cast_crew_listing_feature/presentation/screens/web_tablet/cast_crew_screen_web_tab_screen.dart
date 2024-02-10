import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/dominant_color_from_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/screens/cast_crew_list_item.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';

class CastCrewWebTabScreen extends StatelessWidget {
  final bool isMovies;
  final String imageUrl;
  final String mediaName;

  const CastCrewWebTabScreen({
    super.key,
    required this.isMovies,
    required this.imageUrl,
    required this.mediaName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastCrewCubit, CastCrewState>(
      builder: (context, state) {
        if (state.castCrewStatus is CastCrewLoading || state.castCrewStatus is CastCrewNone) {
          return const Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(),
            ),
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
        final casts = state.mediaCredit?.cast ?? [];
        final crews = state.mediaCredit?.crew ?? [];
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                height: 120,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: DominantColorFromImage(
                        imageProvider: ExtendedNetworkImageProvider(
                          imageUrl,
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
                                imageUrl: imageUrl,
                                width: 58,
                                height: 87,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  mediaName,
                                  style: context.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
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
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: casts.isNotEmpty && crews.isNotEmpty
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  numberCastValue(context, state),
                                  style: context.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: casts.length,
                                  itemBuilder: (ctx, index) {
                                    return CastCrewListItem(
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
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  numberCrewValue(context, state),
                                  style: context.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.groupCrew.length,
                                  itemBuilder: (ctx, index) {
                                    final values =
                                        state.groupCrew[state.groupCrew.keys.toList()[index]] ?? [];
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.groupCrew.keys.toList()[index],
                                          style: context.textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: values.length,
                                          itemBuilder: (ctx, index) {
                                            return CastCrewListItem(
                                              imageUrl: values[index].getImage(),
                                              title: values[index].name ??
                                                  casts[index].originalName ??
                                                  "",
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
                        ],
                      )
                    : (casts.isNotEmpty
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      numberCastValue(context, state),
                                      style: context.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: casts.length,
                                      itemBuilder: (ctx, index) {
                                        return CastCrewListItem(
                                          imageUrl: casts[index].getImage(),
                                          title:
                                              casts[index].name ?? casts[index].originalName ?? "",
                                          subtitle: casts[index].character ?? "",
                                          id: casts[index].id.toString(),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        : (crews.isNotEmpty
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          numberCrewValue(context, state),
                                          style: context.textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state.groupCrew.length,
                                          itemBuilder: (ctx, index) {
                                            final values = state.groupCrew[
                                                    state.groupCrew.keys.toList()[index]] ??
                                                [];
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.groupCrew.keys.toList()[index],
                                                  style: context.textTheme.titleLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: values.length,
                                                  itemBuilder: (ctx, index) {
                                                    return CastCrewListItem(
                                                      imageUrl: values[index].getImage(),
                                                      title: values[index].name ??
                                                          casts[index].originalName ??
                                                          "",
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
                                ],
                              )
                            : const SizedBox.shrink())),
              ),
            ),
          ],
        );
      },
    );
  }

  String numberCastValue(BuildContext context, CastCrewState state) {
    return isMovies
        ? context.tr.castNumber(state.mediaCredit?.cast?.length.toString() ?? "")
        : context.tr.seriesCastNumber(state.mediaCredit?.cast?.length.toString() ?? "");
  }

  String numberCrewValue(BuildContext context, CastCrewState state) {
    return isMovies
        ? context.tr.crewNumber(state.mediaCredit?.crew?.length.toString() ?? "")
        : context.tr.seriesCrewNumber(state.mediaCredit?.crew?.length.toString() ?? "");
  }
}
