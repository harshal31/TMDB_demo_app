import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';

class SystemCubit extends Cubit<SystemState> {
  SystemCubit() : super(SystemState.initial());

  void updateTheme(bool value) async {
    await GetIt.instance.get<HiveManager>().putBool(HiveKey.theme, value);
    emit(
      state.copyWith(themeState: value),
    );
  }
}

/// this state will work for any app/system level state such as theme and language change
class SystemState with EquatableMixin {
  bool? themeState;

  SystemState({this.themeState});

  factory SystemState.initial() {
    return SystemState();
  }

  SystemState copyWith({bool? themeState}) {
    return SystemState(
      themeState: themeState ?? this.themeState,
    );
  }

  @override
  List<Object?> get props => [themeState];
}
