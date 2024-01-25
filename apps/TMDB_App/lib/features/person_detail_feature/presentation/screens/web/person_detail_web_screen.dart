import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/cubits/person_detail_cubit.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/use_cases/person_detail_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_side_view.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class PersonDetailWebScreen extends StatelessWidget {
  const PersonDetailWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonDetailCubit, PersonDetailState>(
      builder: (context, state) {
        if (state.personDetailStatus is PersonDetailNone ||
            state.personDetailStatus is PersonDetailLoading) {
          return const Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.personDetailStatus is PersonDetailFailed) {
          return Center(
            child: Text(
              (state.personDetailStatus as PersonDetailFailed).errorMessage,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 570,
                  child: Row(
                    children: [
                      ExtendedImageCreator(
                        imageUrl: state.personDetailModel.profilePathImageUrl,
                        width: 300,
                        height: 450,
                        fit: BoxFit.cover,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(width: 28),
                      Expanded(
                        child: Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Text(
                                state.personDetailModel.personDetail?.name ?? "",
                                style: context.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                context.tr.biography,
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              AnimatedReadMoreText(
                                state.personDetailModel.personDetail?.biography ?? "",
                                maxLines: 10,
                                readMoreText: context.tr.readMore,
                                readLessText: context.tr.readLess,
                                textStyle: context.textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                context.tr.knownFor,
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 195,
                                child: ListView.separated(
                                  separatorBuilder: (ctx, i) => const SizedBox(width: 16),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.personDetailModel.knownFor?.length ?? 0,
                                  itemBuilder: (ctx, i) {
                                    return ExtendedImageCreator(
                                      imageUrl:
                                          state.personDetailModel.knownFor?[i].imagePosterPath ??
                                              "",
                                      width: 130,
                                      height: 195,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TmdbSidePersonView(
                        personDetail: state.personDetailModel.personDetail,
                        tmdbShare: state.personDetailModel.tmdbShare,
                      ),
                    ),
                    const SizedBox(width: 28),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.personDetailModel.mapping.length,
                          itemBuilder: (ctx, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  state.personDetailModel.mapping[index]?.firstOrNull?.department ??
                                      "",
                                  style: context.textTheme.titleLarge,
                                ),
                                const SizedBox(height: 16),
                                Card(
                                  elevation: 10,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: state.personDetailModel.mapping[index]?.length ?? 0,
                                    itemBuilder: (ctx, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  state.personDetailModel.mapping[index]?[i]
                                                          .releaseDate.getDateTime?.year
                                                          .toString() ??
                                                      "-",
                                                  style: context.textTheme.bodyLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Flexible(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      CommonNavigation.redirectToDetailScreen(
                                                          context,
                                                          mediaType: state.personDetailModel
                                                                  .mapping[index]?[i].mediaType ??
                                                              "",
                                                          mediaId: state.personDetailModel
                                                                  .mapping[index]?[i].id
                                                                  .toString() ??
                                                              "");
                                                    },
                                                    onHover: (s) => s,
                                                    child: Text(
                                                      state.personDetailModel.mapping[index]?[i]
                                                              .originalTitle ??
                                                          "",
                                                      style: context.textTheme.bodyLarge?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.start,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const Spacer(),
                                                Flexible(
                                                  flex: state.personDetailModel.mapping[index]?[i]
                                                              .releaseDate.getDateTime?.year !=
                                                          null
                                                      ? 10
                                                      : 18,
                                                  child: Text(
                                                    "${state.personDetailModel.mapping[index]?[i].episodeCount != null ? context.tr.episodeMapping(state.personDetailModel.mapping[index]?[i].episodeCount ?? "") : ""}${context.tr.asCharacter(state.personDetailModel.mapping[index]?[i].job ?? "")}",
                                                    style: context.textTheme.bodySmall,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                const Spacer(flex: 2),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, i) {
                                      return Divider(
                                        color: context.colorTheme.onSurface.withOpacity(0.4),
                                        thickness: 1.0,
                                        height: 1.0,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
