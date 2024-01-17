import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingPositionCubit extends Cubit<TrendingPositionState> {
  TrendingPositionCubit() : super(TrendingPositionState.initial());

  void storePosition(int? pos, bool? switchState) {
    emit(TrendingPositionState(pos ?? 0, switchState ?? true));
  }
}

class TrendingPositionState with EquatableMixin {
  final int pos;
  final bool switchState;

  TrendingPositionState(this.pos, this.switchState);

  factory TrendingPositionState.initial() {
    return TrendingPositionState(0, true);
  }

  String getTrendingText(BuildContext context) {
    final tr = context.tr.trending;
    final result = this.switchState ? context.tr.today : context.tr.thisWeek;
    return "$tr $result";
  }

  List<String> getTrendingTabTitles(BuildContext context) {
    return [
      context.tr.all,
      context.tr.movies,
      context.tr.tv,
      context.tr.people,
    ];
  }

  @override
  List<Object?> get props => [pos, switchState];
}
