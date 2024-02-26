import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/read_more_text.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_credit.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/cubits/person_detail_cubit.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/use_cases/person_detail_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_side_view.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class PersonDetailTabletScreen extends StatelessWidget {
  const PersonDetailTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonDetailCubit, PersonDetailState>(
      builder: (context, state) {
        if (state.personDetailStatus is PersonDetailNone ||
            state.personDetailStatus is PersonDetailLoading) {
          return const Center(
            child: LottieLoader(),
          );
        }

        if (state.personDetailStatus is PersonDetailFailed) {
          return Center(
            child: WrappedText(
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              WrappedText(
                                state.personDetailModel.personDetail?.name ?? "",
                                style: context.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Visibility(
                                visible: (state.personDetailModel.personDetail?.biography ?? "")
                                    .isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    WrappedText(
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
                                  ],
                                ),
                                replacement: const SizedBox.shrink(),
                              ),
                              Visibility(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WrappedText(
                                      context.tr.knownFor,
                                      style: context.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      height: 195,
                                      child: InkWell(
                                        child: ListView.separated(
                                          separatorBuilder: (ctx, i) => const SizedBox(width: 16),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.personDetailModel.knownFor?.length ?? 0,
                                          itemBuilder: (ctx, i) {
                                            return InkWell(
                                              borderRadius: BorderRadius.circular(10),
                                              onTap: () {
                                                CommonNavigation.redirectToDetailScreen(
                                                  context,
                                                  mediaType: state
                                                      .personDetailModel.knownFor?[i].mediaType,
                                                  mediaId: state.personDetailModel.knownFor?[i].id
                                                      .toString(),
                                                );
                                              },
                                              child: ExtendedImageCreator(
                                                imageUrl: state.personDetailModel.knownFor?[i]
                                                        .imagePosterPath ??
                                                    "",
                                                width: 130,
                                                height: 195,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.personDetailModel.mapping.length,
                        itemBuilder: (ctx, index) {
                          return Column(
                            key: ValueKey(index),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              WrappedText(
                                state.personDetailModel.mapping[index]?.firstOrNull?.department ??
                                    "",
                                style: context.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              Card(
                                elevation: 10,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.personDetailModel.mapping[index]?.length ?? 0,
                                  itemBuilder: (ctx, i) {
                                    final (result, after) = getPersonResult(
                                      context,
                                      state.personDetailModel.mapping[index]?[i],
                                    );
                                    return Padding(
                                      key: ValueKey(i),
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: WrappedText(
                                                  state.personDetailModel.mapping[index]?[i]
                                                          .getActualDate()
                                                          .getDateTime
                                                          ?.year
                                                          .toString() ??
                                                      "-",
                                                  style: context.textTheme.bodyLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                flex: 9,
                                                child: TextButton(
                                                  onPressed: () {
                                                    CommonNavigation.redirectToDetailScreen(context,
                                                        mediaType: state.personDetailModel
                                                                .mapping[index]?[i].mediaType ??
                                                            "",
                                                        mediaId: state.personDetailModel
                                                                .mapping[index]?[i].id
                                                                .toString() ??
                                                            "");
                                                  },
                                                  onHover: (s) => s,
                                                  child: WrappedText(
                                                    state.personDetailModel.mapping[index]?[i]
                                                            .getActualName() ??
                                                        "",
                                                    style: context.textTheme.bodyLarge?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: after.isNotEmpty,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: WrappedText(
                                                    "$result",
                                                    style: context.textTheme.bodySmall,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
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

  (String, String) getPersonResult(BuildContext context, PersonCrew? state) {
    final result =
        "${state?.episodeCount != null ? context.tr.episodeMapping(state?.episodeCount ?? "") : ""}${context.tr.asCharacter(state?.job ?? "")}";
    final after = state?.episodeCount != null ? result.split(" ")[0] : result.split(" ")[1];
    return (result, after);
  }
}
