import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/login_use_case.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/session_use_case.dart";

class AuthenticationCubit extends Cubit<LoginState> {
  final LoginUseCase _useCase;
  final SessionUseCase _sessionUseCase;
  final ScrollController scrollController = ScrollController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthenticationCubit(this._useCase, this._sessionUseCase) : super(LoginState.initial());

  void login(String userName, String password) async {
    emit(state.copyWith(status: LoginLoading()));
    final response = await _useCase.validateWithLogin(
      userName: userName,
      password: password,
    );

    response.fold((l) {
      emit(state.copyWith(status: LoginFailed(l.errorMessage)));
    }, (r) async {
      final token =
          await GetIt.instance.get<HiveManager>().getString(HiveKey.requestToken);
      final createSession = await _sessionUseCase.createNewSession(token: token);

      createSession.fold(
        (l) {
          emit(state.copyWith(status: LoginFailed(l.errorMessage)));
        },
        (r) {
          emit(state.copyWith(status: LoginSuccess("Login Successfully")));
        },
      );
    });
  }

  void updatePasswordVisibility() {
    emit(state.copyWith(shouldVisiblePassword: !state.shouldObscure));
  }

  void disposeControllers() {
    scrollController.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }
}
