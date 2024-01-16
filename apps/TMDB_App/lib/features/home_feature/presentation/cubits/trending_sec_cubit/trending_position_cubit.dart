import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingPositionCubit extends Cubit<TrendingPositionState> {
  TrendingPositionCubit() : super(TrendingPositionState.initial());

  void storePosition(int? pos, bool? switchState) {
    final li = List.of(state.switchStates);
    li[(pos ?? 0)] = switchState ?? true;
    emit(TrendingPositionState(pos ?? 0, li));
  }
}

class TrendingPositionState with EquatableMixin {
  final int pos;
  final List<bool> switchStates;

  TrendingPositionState(this.pos, this.switchStates);

  factory TrendingPositionState.initial() {
    return TrendingPositionState(0, [true, true, true, true]);
  }

  String getTrendingText(BuildContext context) {
    final tr = context.tr.trending;
    final result = this.switchStates[this.pos] ? context.tr.today : context.tr.thisWeek;
    return "$tr $result";
  }

  @override
  List<Object?> get props => [pos, switchStates];
}
