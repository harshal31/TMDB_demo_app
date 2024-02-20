import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/app_level_provider/system_cubit.dart';
import 'package:tmdb_app/constants/hive_key.dart';

class TmdbAnimatedIconSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
      buildWhen: (prev, cur) => prev != cur,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return RotationTransition(
              turns: animation,
              child: child,
            );
          },
          child: (state.themeState ?? GetIt.instance.get<bool>(instanceName: HiveKey.theme))
              ? IconButton.outlined(
                  key: ValueKey(state),
                  icon: const Icon(Icons.light_mode),
                  onPressed: () {
                    context.read<SystemCubit>().updateTheme(false);
                  },
                )
              : IconButton.outlined(
                  key: ValueKey(state),
                  icon: const Icon(Icons.dark_mode),
                  onPressed: () {
                    context.read<SystemCubit>().updateTheme(true);
                  },
                ),
        );
      },
    );
  }

  TmdbAnimatedIconSwitcher();
}
