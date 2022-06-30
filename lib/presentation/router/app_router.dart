import 'package:flutter/material.dart';
import '../screens/auth_screen/login_screen.dart';
import '../screens/auth_screen/register_screen.dart';
import '../screens/shared/splash_screen.dart';
import '../screens/user/user_profile.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/userProfile':
        return MaterialPageRoute(builder: (_) => UserProfile());
      default:
        return null;
    }
  }
}
