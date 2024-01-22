import "package:common_widgets/gen/app_asset.dart";
import "package:common_widgets/localizations/localized_extension.dart";
import "package:common_widgets/theme/app_theme.dart";
import "package:common_widgets/widgets/snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/authentication_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/button_state_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/login_use_case.dart";
import "package:tmdb_app/routes/route_name.dart";

class AuthenticationMobileScreen extends StatelessWidget {
  const AuthenticationMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();
    return BlocConsumer<AuthenticationCubit, LoginState>(
      listener: (context, state) {
        if (state.status is LoginFailed) {
          showSimpleSnackBar(context, (state.status as LoginFailed).message);
        }
        if (state.status is LoginSuccess) {
          context.replace(RouteName.home);
        }
      },
      builder: (context, state) {
        repositionScrollPositionAtCenter(authenticationCubit);
        return Form(
          key: authenticationCubit.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: authenticationCubit.scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppAsset.images.tmdbLogo.image(
                          package: "common_widgets", height: 150, width: 250, fit: BoxFit.cover),
                      TextFormField(
                        controller: authenticationCubit.userNameController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (s) {
                          if (authenticationCubit.shouldSkipUserNameError) {
                            return null;
                          }
                          if (s?.isEmpty ?? true) {
                            return context.tr.invalidUserNameMessage;
                          }
                          return null;
                        },
                        onChanged: (_) {
                          context.read<ButtonStateCubit>().updateButtonState(
                              authenticationCubit.userNameController.text.isEmpty ||
                                  authenticationCubit.passwordController.text.isEmpty);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          border: const OutlineInputBorder(),
                          hintText: context.tr.userName,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: authenticationCubit.passwordController,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: state.shouldObscure,
                        validator: (s) {
                          if (s?.isEmpty ?? true) {
                            return context.tr.invalidPasswordMessage;
                          }

                          return null;
                        },
                        onChanged: (c) {
                          if (c.length == 1) {
                            authenticationCubit.formKey.currentState?.validate();
                          }
                          context.read<ButtonStateCubit>().updateButtonState(
                              authenticationCubit.userNameController.text.isEmpty ||
                                  authenticationCubit.passwordController.text.isEmpty);
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (authenticationCubit.passwordController.text.isEmpty) {
                                authenticationCubit.shouldSkipUserNameError = true;
                                authenticationCubit.formKey.currentState?.validate();
                                return;
                              } else {
                                authenticationCubit.shouldSkipUserNameError = false;
                              }

                              context.read<AuthenticationCubit>().updatePasswordVisibility();
                            },
                            icon: Icon(
                              state.shouldObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          border: const OutlineInputBorder(),
                          hintText: context.tr.password,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: state.status is LoginLoading
                            ? Container(
                                key: UniqueKey(),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              )
                            : BlocBuilder<ButtonStateCubit, bool>(
                                key: UniqueKey(),
                                builder: (context, state) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: context.colorTheme.primaryContainer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                      onPressed: state
                                          ? null
                                          : () {
                                              authenticationCubit.shouldSkipUserNameError = false;
                                              if (authenticationCubit.formKey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                context.read<AuthenticationCubit>().login(
                                                      authenticationCubit.userNameController.text,
                                                      authenticationCubit.passwordController.text,
                                                    );
                                              }
                                            },
                                      child: Text(
                                        context.tr.login,
                                        style: context.textTheme.titleMedium,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void repositionScrollPositionAtCenter(AuthenticationCubit authenticationCubit) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (authenticationCubit.scrollController.positions.isNotEmpty) {
        authenticationCubit.scrollController.jumpTo(
          authenticationCubit.scrollController.position.maxScrollExtent,
        );
      }
    });
  }
}