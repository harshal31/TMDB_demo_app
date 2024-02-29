import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<bool> {
  BottomNavCubit() : super(false);

  void changeBottomNavVisibility(bool value) {
    emit(value);
  }
}
