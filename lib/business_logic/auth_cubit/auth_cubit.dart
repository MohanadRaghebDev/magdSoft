import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/constants/end_points.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/data/models/login_model.dart';
import '../../data/remote/dio_helper.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStateInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  /// changing password visibility
  bool changePasswordVisibility = true;
  void toggle() {
    changePasswordVisibility = !changePasswordVisibility;
    emit(PasswordVisibilityState());
  }

  /// changing language
  bool isArabic = true;
  void languageChange() {
    isArabic = !isArabic;
    if (isArabic) {
      CacheHelper.saveDataSharedPreference(key: 'language', value: 'ar');
      emit(ChangeLanguageToArabicState());
    } else {
      CacheHelper.saveDataSharedPreference(key: 'language', value: 'en');
      emit(ChangeLanguageToEnglishState());
    }
  }

  /// user login method
  LoginModel? loginModel;
  void userLogin({required String email, required String password}) {
    emit(AuthLoadingState());
    DioHelper.postData(
      url: login,
      body: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      CacheHelper.saveDataSharedPreference(
          key: 'name', value: loginModel!.account![0].name);
      CacheHelper.saveDataSharedPreference(
          key: 'email', value: loginModel!.account![0].email);
      CacheHelper.saveDataSharedPreference(
          key: 'phone', value: loginModel!.account![0].phone);
      emit(AuthSuccessState());
    }).catchError((error) {
      emit(AuthErrorState(error));
    });
  }

  /// navigation from login to account and saving login in shared pref
  void goToAccount(BuildContext context, Widget widget) {
    CacheHelper.saveDataSharedPreference(key: 'login', value: true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
    emit(AuthFinishedState());
  }

  /// user register method
  void userRegister(
      {required String email,
      required String password,
      required String name,
      required int phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: register,
      body: {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
      },
    ).then((value) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }
}
