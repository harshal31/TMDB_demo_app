import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestPositionCubit extends Cubit<LatestPositionState> {
  LatestPositionCubit() : super(LatestPositionState.initial());

  void storePosition(
    int? pos,
    bool currentSwitchState,
  ) {
    emit(state.copyWith(
      pos: pos,
      currentSwitchState: currentSwitchState,
    ));
  }
}

class LatestPositionState with EquatableMixin {
  final int pos;
  final bool currentSwitchState;

  LatestPositionState(this.pos, this.currentSwitchState);

  factory LatestPositionState.initial() {
    return LatestPositionState(
      0,
      true,
    );
  }

  String getLatestText(BuildContext context) {
    final tr = context.tr.latest;
    final result = currentSwitchState ? context.tr.movies : context.tr.tvSeries;
    return "$tr $result";
  }

  List<String> getLatestTabTitles(BuildContext context) {
    return (currentSwitchState
        ? [
            context.tr.nowPlaying,
            context.tr.popular,
            context.tr.topRated,
            context.tr.upcoming,
          ]
        : [
            context.tr.airingToday,
            context.tr.popular,
            context.tr.topRated,
            context.tr.onTheAir,
          ]);
  }

  LatestPositionState copyWith({int? pos, bool? currentSwitchState}) {
    return LatestPositionState(
      pos ?? this.pos,
      currentSwitchState ?? this.currentSwitchState,
    );
  }

  @override
  List<Object?> get props => [
        pos,
        currentSwitchState,
      ];
}
