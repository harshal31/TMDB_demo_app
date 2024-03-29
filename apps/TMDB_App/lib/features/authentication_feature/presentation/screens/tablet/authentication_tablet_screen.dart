import "package:common_widgets/gen/app_asset.dart";
import "package:common_widgets/localizations/localized_extension.dart";
import "package:common_widgets/theme/theme_util.dart";
import "package:common_widgets/widgets/snackbar.dart";
import "package:common_widgets/widgets/wrapped_text.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/authentication_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/button_state_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/login_use_case.dart";
import "package:tmdb_app/routes/route_name.dart";

class AuthenticationTabletScreen extends StatefulWidget {
  const AuthenticationTabletScreen({super.key});

  @override
  State<AuthenticationTabletScreen> createState() => _AuthenticationTabletScreenState();
}

class _AuthenticationTabletScreenState extends State<AuthenticationTabletScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();

    return BlocConsumer<AuthenticationCubit, LoginState>(
      listener: (context, state) {
        if (state.status is LoginFailed) {
          showSimpleSnackBar(context, (state.status as LoginFailed).message);
        }

        if (state.status is LoginSuccess) {
          context.go(RouteName.home);
        }
      },
      builder: (context, state) {
        repositionScrollPositionAtCenter(authenticationCubit);
        return Form(
          key: formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppAsset.images.tmdbLogo.image(
                        package: "common_widgets",
                        height: 300,
                      ),
                      TextFormField(
                        controller: userNameController,
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
                              userNameController.text.isEmpty || passwordController.text.isEmpty);
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: context.colorTheme.primary,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          border: const OutlineInputBorder(),
                          hintText: context.tr.userName,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
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
                            formKey.currentState?.validate();
                          }
                          context.read<ButtonStateCubit>().updateButtonState(
                              userNameController.text.isEmpty || passwordController.text.isEmpty);
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: context.colorTheme.primary,
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (passwordController.text.isEmpty) {
                                authenticationCubit.shouldSkipUserNameError = true;
                                formKey.currentState?.validate();
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
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: context.colorTheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                      onPressed: state
                                          ? null
                                          : () {
                                              authenticationCubit.shouldSkipUserNameError = false;
                                              if (formKey.currentState?.validate() ?? false) {
                                                context.read<AuthenticationCubit>().login(
                                                      userNameController.text,
                                                      passwordController.text,
                                                    );
                                              }
                                            },
                                      child: WrappedText(
                                        context.tr.login,
                                        style: context.textTheme.titleMedium?.copyWith(
                                          color: state
                                              ? context.colorTheme.onSurface
                                              : context.colorTheme.onPrimary,
                                          fontWeight: state ? null : FontWeight.bold,
                                        ),
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
      if (scrollController.positions.isNotEmpty) {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }
}
