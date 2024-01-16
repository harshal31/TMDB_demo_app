import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestPositionCubit extends Cubit<LatestPositionState> {
  LatestPositionCubit() : super(LatestPositionState.initial());

  void storePosition(int? pos, bool? switchState) {
    final li = List.of(state.switchStates);
    li[(pos ?? 0)] = switchState ?? true;
    emit(LatestPositionState(pos ?? 0, li));
  }
}

class LatestPositionState with EquatableMixin {
  final int pos;
  final List<bool> switchStates;

  LatestPositionState(this.pos, this.switchStates);

  factory LatestPositionState.initial() {
    return LatestPositionState(0, [true, true, true, true]);
  }

  String getLatestText(BuildContext context) {
    final tr = context.tr.latest;
    final result = this.switchStates[this.pos] ? context.tr.movies : context.tr.tvSeries;
    return "$tr $result";
  }

  @override
  List<Object?> get props => [pos, switchStates];
}
