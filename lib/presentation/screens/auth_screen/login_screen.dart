import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/auth_cubit/auth_states.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/auth_screen/register_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_profile.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../constants/constants.dart';
import '../../widget/defaultTextFormField.dart';
import '../../widget/sign_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

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
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            decoration: langButtonDecoration,
                            width: 100,
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                cubit.languageChange();
                              },
                              child: Text(
                                CacheHelper.getDataFromSharedPreference(
                                            key: 'language') ==
                                        'ar'
                                    ? 'عربي'
                                    : 'en',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Center(
                          child: Image(
                              image:
                                  AssetImage('assets/images/login_image.png')),
                        )
                      ],
                    ),
                  ),

                  /// login form
                  Expanded(
                    flex: 3,
                    child: Container(
                        width: double.infinity,
                        decoration: signInFormDecoration,
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: DefaultTextFormField(
                                    controller: emailController,
                                    hintText:
                                        AppLocalizations.of(context)!.email,
                                    validateText: AppLocalizations.of(context)!
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

                              /// password text field
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: DefaultTextFormField(
                                    obSecure: cubit.changePasswordVisibility,
                                    controller: passwordController,
                                    hintText:
                                        AppLocalizations.of(context)!.password,
                                    validateText: AppLocalizations.of(context)!
                                        .passwordRequired,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .passwordRequired;
                                      }
                                      return null;
                                    },
                                    suffixIconWidget: IconButton(
                                        onPressed: () {
                                          cubit.toggle();
                                        },
                                        icon: cubit.changePasswordVisibility
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility))),
                              ),
                              const SizedBox(
                                height: 120,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  /// register button
                                  SignButton(
                                      colour: AppColor.mainColor,
                                      buttonText: AppLocalizations.of(context)!
                                          .register,
                                      onPressing: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterScreen()));
                                      }),

                                  /// login button
                                  SignButton(
                                      colour: AppColor.mainColor,
                                      buttonText:
                                          AppLocalizations.of(context)!.login,
                                      onPressing: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userLogin(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                          cubit.goToAccount(
                                              context, UserProfile());
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        }
                                      })
                                ],
                              )
                            ],
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
