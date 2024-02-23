import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<bool> {
  BottomNavCubit() : super(true);

  void changeBottomNavVisibility(bool value) {
    emit(value);
  }
}
