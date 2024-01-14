import "package:common_widgets/gen/app_asset.dart";
import "package:common_widgets/localizations/localized_extension.dart";
import "package:common_widgets/widgets/snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/authentication_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/cubits/button_state_cubit.dart";
import "package:tmdb_app/features/authentication_feature/presentation/use_case/login_use_case.dart";
import "package:tmdb_app/theme/app_theme.dart";

class AuthenticationMobile extends StatefulWidget {
  @override
  State<AuthenticationMobile> createState() => _AuthenticationMobileState();
}

class _AuthenticationMobileState extends State<AuthenticationMobile> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool shouldSkipUserNameError = false;

  @override
  Widget build(BuildContext context) {
    if (_scrollController.positions.isNotEmpty) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }

    return BlocConsumer<AuthenticationCubit, LoginState>(
      listener: (context, state) {
        if (state.status is LoginFailed) {
          showSimpleSnackBar(context, (state.status as LoginFailed).message);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppAsset.images.tmdbLogo.image(
                        package: "common_widgets",
                        height: 100,
                      ),
                      TextFormField(
                        controller: _userNameController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (s) {
                          if (shouldSkipUserNameError) {
                            return null;
                          }
                          if (s?.isEmpty ?? true) {
                            return context.tr.invalidUserNameMessage;
                          }
                          return null;
                        },
                        onChanged: (_) {
                          context.read<ButtonStateCubit>().updateButtonState(
                              _userNameController.text.isEmpty ||
                                  _passwordController.text.isEmpty);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(),
                          hintText: context.tr.userName,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: state.shouldObscure,
                        validator: (s) {
                          if (s?.isEmpty ?? true) {
                            return context.tr.invalidPasswordMessage;
                          }

                          return null;
                        },
                        onChanged: (_) {
                          context.read<ButtonStateCubit>().updateButtonState(
                              _userNameController.text.isEmpty ||
                                  _passwordController.text.isEmpty);
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (_passwordController.text.isEmpty) {
                                shouldSkipUserNameError = true;
                                _formKey.currentState?.validate();
                                return;
                              } else {
                                shouldSkipUserNameError = false;
                              }

                              context
                                  .read<AuthenticationCubit>()
                                  .updatePasswordVisibility();
                            },
                            icon: Icon(
                              state.shouldObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(),
                          hintText: context.tr.password,
                        ),
                      ),
                      SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: state.status is LoginLoading
                            ? Container(
                                key: UniqueKey(),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              )
                            : BlocBuilder<ButtonStateCubit, bool>(
                                key: UniqueKey(),
                                builder: (context, state) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            context.colorTheme.primaryContainer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                      onPressed: state
                                          ? null
                                          : () {
                                              shouldSkipUserNameError = false;
                                              if (_formKey.currentState?.validate() ??
                                                  false) {
                                                context.read<AuthenticationCubit>().login(
                                                      _userNameController.text,
                                                      _passwordController.text,
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
}
