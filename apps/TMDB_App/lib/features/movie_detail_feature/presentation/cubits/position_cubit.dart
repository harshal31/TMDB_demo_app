import 'package:flutter_bloc/flutter_bloc.dart';

class PositionCubit extends Cubit<int> {
  PositionCubit(super.initialState);

  void updatePos(int value) {
    if (state != value) {
      emit(value);
    }
  }
}
