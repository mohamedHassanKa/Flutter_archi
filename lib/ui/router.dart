import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter/services.dart';
// import 'package:vacation_rentals/ui/views/HomeView.dart';
// import 'package:vacation_rentals/ui/views/change_password.dart';
// import 'package:vacation_rentals/ui/views/forgot_password.dart';
// import 'package:vacation_rentals/ui/views/login.dart';
// import 'package:vacation_rentals/ui/views/registerScreen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
// import './views/dashboardScreen.dart';
import './views/walkthrough.dart';
import './views/login.dart';
import './shared/naviguation_effects.dart';

const String initialRoute = "login";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Walkthrough());
    case '/walkthrough':
      return MaterialPageRoute(builder: (context) => Walkthrough());

    // case '/register':
    //   return Platform.isIOS
    //       ? CupertinoPageRoute(builder: (context) => RegisterScreen())
    //       : MaterialPageRoute(builder: (context) => RegisterScreen());
    // case '/forgotPassword':
    //   return Platform.isIOS
    //       ? CupertinoPageRoute(builder: (context) => ForgotPasswordScreen())
    //       : MaterialPageRoute(builder: (context) => ForgotPasswordScreen());

    // case '/homeView':
    //   return Platform.isIOS
    //       ? CupertinoPageRoute(builder: (context) => HomeView())
    //       : MaterialPageRoute(builder: (context) => HomeView());
    case '/login':
      return Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => LoginPage())
          : ScaleTransition2(page: LoginPage());

    // case '/changePassword':
    //   return Platform.isIOS
    //       ? CupertinoPageRoute(builder: (context) => ChangePassword())
    //       : MaterialPageRoute(builder: (context) => ChangePassword());
    // case '/dashboard':
    //   return MaterialPageRoute(builder: (context) => DashboardScreen());
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
