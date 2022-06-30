abstract class AuthStates {}

class AuthStateInitial extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String error;
  AuthErrorState(this.error);
}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String error;
  RegisterErrorState(this.error);
}

class AuthFinishedState extends AuthStates {}

class PasswordVisibilityState extends AuthStates {}

class ChangeLanguageToArabicState extends AuthStates {}

class ChangeLanguageToEnglishState extends AuthStates {}
