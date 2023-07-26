import 'package:flutter/material.dart';
import 'package:project_study/auth/login.dart';
import 'package:project_study/auth/register.dart';
import 'package:project_study/home/home.dart';

import '../splash/splash_screen.dart';

abstract class AppRoutes {
  static final pages = <String, WidgetBuilder>{
    "/register": (context) => const Register(),
    "/login": (context) => const Login(),
    "/home": (context) => const Home(),
    "/splash": (context) => const SplashScreen(),
  };
}
