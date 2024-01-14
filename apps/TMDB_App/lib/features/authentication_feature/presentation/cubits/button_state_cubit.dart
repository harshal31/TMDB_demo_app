import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStateCubit extends Cubit<bool> {
  ButtonStateCubit(super.initialState);

  void updateButtonState(bool shouldEnable) {
    emit(shouldEnable);
  }
}
