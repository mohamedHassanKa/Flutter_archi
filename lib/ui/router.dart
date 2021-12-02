import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
// import './views/dashboardScreen.dart';
import './views/walkthrough.dart';
import './views/login.dart';
import './shared/naviguation_effects.dart';
import './views/registration.dart';
import './views/change_password.dart';
import './views/dashboard_screen.dart';
import './views/home_view.dart';

const String initialRoute = "login";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Walkthrough());
    case '/walkthrough':
      return MaterialPageRoute(builder: (context) => Walkthrough());

    case '/register':
      return Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => RegisterScreen())
          : MaterialPageRoute(builder: (context) => RegisterScreen());
    case '/forgotPassword':
      return Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => ChangePassword())
          : MaterialPageRoute(builder: (context) => ChangePassword());

    case '/home':
      return Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => HomeView())
          : MaterialPageRoute(builder: (context) => HomeView());
    case '/login':
      return Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => LoginPage())
          : ScaleTransition2(page: LoginPage());

    // case '/changePassword':
    //   return Platform.isIOS
    //       ? CupertinoPageRoute(builder: (context) => ChangePassword())
    //       : MaterialPageRoute(builder: (context) => ChangePassword());
    case '/dashboard':
      return MaterialPageRoute(builder: (context) => DashboardScreen());
    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('No route defined for ${settings.name}'),
                    ),
                  ],
                ),
              ));
  }
}
