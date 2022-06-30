import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/auth_screen/login_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../business_logic/auth_cubit/auth_states.dart';
import '../../../constants/constants.dart';
import '../../widget/defaultTextFormField.dart';
import '../../widget/sign_button.dart';
import '../user/user_profile.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColor.mainColor,
            body: SafeArea(
              child: Column(
                children: [
                  /// Stack for lang button and image
                  const Expanded(
                    flex: 1,
                    child: Center(
                      child: Image(
                          image: AssetImage('assets/images/login_image.png')),
                    ),
                  ),

                  /// login form
                  Expanded(
                    flex: 3,
                    child: Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        width: double.infinity,
                        decoration: signInFormDecoration,
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /// full name text field
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: DefaultTextFormField(
                                      controller: nameController,
                                      hintText: AppLocalizations.of(context)!
                                          .fullName,
                                      validateText:
                                          AppLocalizations.of(context)!
                                              .fullNameRequired,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .fullNameRequired;
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                ///email text field
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: DefaultTextFormField(
                                      controller: emailController,
                                      hintText:
                                          AppLocalizations.of(context)!.email,
                                      validateText:
                                          AppLocalizations.of(context)!
                                              .emailIsRequired,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .emailIsRequired;
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                /// phone text field
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: DefaultTextFormField(
                                      controller: phoneController,
                                      hintText:
                                          AppLocalizations.of(context)!.phone,
                                      validateText:
                                          AppLocalizations.of(context)!
                                              .phoneRequired,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .phoneRequired;
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                ///password text field
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: DefaultTextFormField(
                                      controller: passwordController,
                                      hintText: AppLocalizations.of(context)!
                                          .password,
                                      obSecure: cubit.changePasswordVisibility,
                                      validateText:
                                          AppLocalizations.of(context)!
                                              .passwordRequired,
                                      suffixIconWidget: IconButton(
                                          onPressed: () {
                                            cubit.toggle();
                                          },
                                          icon: cubit.changePasswordVisibility
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility)),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .passwordRequired;
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                /// confirm password text field
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: DefaultTextFormField(
                                      obSecure: cubit.changePasswordVisibility,
                                      controller: confirmPasswordController,
                                      hintText: AppLocalizations.of(context)!
                                          .confirmPassword,
                                      validateText:
                                          AppLocalizations.of(context)!
                                              .passwordRequired,
                                      suffixIconWidget: IconButton(
                                          onPressed: () {
                                            cubit.toggle();
                                          },
                                          icon: cubit.changePasswordVisibility
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility)),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .passwordRequired;
                                        } else if (confirmPasswordController
                                                .text !=
                                            passwordController.text) {
                                          return AppLocalizations.of(context)!
                                              .passwordMatch;
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),

                                /// login & register buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    /// register button
                                    SignButton(
                                        colour: AppColor.mainColor,
                                        buttonText:
                                            AppLocalizations.of(context)!
                                                .register,
                                        onPressing: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.userRegister(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              phone: int.parse(
                                                  phoneController.text),
                                            );
                                            cubit.goToAccount(
                                                context, LoginScreen());
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          }
                                        }),

                                    /// login button
                                    SignButton(
                                        colour: AppColor.mainColor,
                                        onPressing: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()));
                                        },
                                        buttonText:
                                            AppLocalizations.of(context)!
                                                .login),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
