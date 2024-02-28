import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/country_flag.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/profile_feature/presentation/cubit/profile_cubit.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/profile_use_case.dart';

class ProfileScreenImpl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.profileStatus is ProfileLoading || state.profileStatus is ProfileNone) {
          return const LinearLoader();
        }

        if (state.profileStatus is ProfileError) {
          return Center(
            child: WrappedText(
              (state.profileStatus as ProfileError).error,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: context.colorTheme.onBackground.withOpacity(0.4), // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: context.colorTheme.onBackground.withOpacity(0.6),
                        radius: 50,
                        child: CircleAvatar(
                          backgroundColor: context.colorTheme.primary.withOpacity(0.6),
                          radius: 50,
                          child: (state.profileDetailModel?.avatar?.tmdb?.avatarPath?.isNotEmpty ??
                                  false)
                              ? Stack(
                                  children: [
                                    Positioned.fill(
                                      child: ExtendedImageCreator(
                                        imageUrl:
                                            state.profileDetailModel?.avatar?.tmdb?.avatarPath ??
                                                "",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: FlagWidget(
                                        code: state.profileDetailModel?.iso31661 ?? "IN",
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: WrappedText(
                                        ((state.profileDetailModel?.name ??
                                                            state.profileDetailModel?.username)
                                                        ?.length ??
                                                    0) >
                                                0
                                            ? (state.profileDetailModel?.name ??
                                                    state.profileDetailModel?.username ??
                                                    "A")[0]
                                                .toUpperCase()
                                            : "A",
                                        style: context.textTheme.displayMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: context.colorTheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: FlagWidget(
                                        code: state.profileDetailModel?.iso31661 ?? "IN",
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: (state.profileDetailModel?.name ??
                                    state.profileDetailModel?.username ??
                                    "")
                                .isNotEmpty,
                            child: WrappedText(
                              context.tr.hello(
                                (state.profileDetailModel?.name ??
                                    state.profileDetailModel?.username ??
                                    ""),
                              ),
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              WrappedText(
                                context.tr.language,
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              WrappedText(
                                (state.profileDetailModel?.iso6391 ?? "en").toString(),
                                style: context.textTheme.titleMedium,
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              WrappedText(
                                context.tr.isAdultIncluded,
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              WrappedText(
                                (state.profileDetailModel?.includeAdult ?? false).toString(),
                                style: context.textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
