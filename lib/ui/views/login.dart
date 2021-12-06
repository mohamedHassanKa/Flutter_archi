import 'package:archi/core/hotel_list_model.dart';
import 'package:archi/core/models/hotel_data_model.dart';
import 'package:archi/ui/widgets/base_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/bottom_curve_painter.dart';
import '../widgets/gradient_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'HomeView.dart';
import 'package:provider/provider.dart';
import '../../core/services/app_localization.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              child: ClipPath(
                clipper: BottomShapeClipper(),
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ClipPath(
              clipper: BottomShapeClipper2(),
              child: Container(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _loginGradientText(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  _textAccount(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  loginFields(context)
                ],
              ),
            )
          ]),
        ));
  }

  GradientText _loginGradientText(context) {
    return GradientText('Login',
        gradient: LinearGradient(colors: [Theme.of(context).primaryColor, const Color(0xFF68D8D6)]),
        style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.bold, fontSize: 42));
  }

  Widget _textAccount(context) {
    return FittedBox(
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              "Don't have an account? ",
              style: Theme.of(context).textTheme.headline6,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Create your account",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.deepOrange)
                      .copyWith(fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ),
    );
  }

  // Container _loginButtonWidget() {
  //   return Container(
  //     height: 50,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         gradient: LinearGradient(colors: [
  //           const Color.fromRGBO(143, 148, 251, 1),
  //           const Color.fromRGBO(143, 148, 251, .6),
  //         ])),
  //     child: Center(
  //       child: Text(
  //         "Login",
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }

  Row _socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        socialCircleAvatar("assets/icons/facebook.png", () {}),
        const SizedBox(width: 18),
        socialCircleAvatar("assets/icons/linkedin.png", () {}),
        const SizedBox(width: 18),
        socialCircleAvatar("assets/icons/twiiter.png", () {}),
      ],
    );
  }

  GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: 24,
        backgroundColor: Colors.transparent,
        child: Image.asset(assetIcon),
      ),
    );
  }

  loginFields(context) {
    // final languageChange = Provider.of<AppLocalizationProvider>(context);
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 8),
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        blurRadius: 20.0,
                        offset: const Offset(0, 10))
                  ]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email or Phone number",
                              hintStyle: TextStyle(color: Colors.grey.shade100)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                BaseViewModelWidget<HotelListModel>(
                  builder: (BuildContext context, HotelListModel _provider) => InkWell(
                    onTap: () {
                      _provider.tryPrint();
                      // languageChange.changeLanguage(context, 'ar');
                      //Navigator.pushNamed(context, '/home');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.5),
                            ])),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.hello,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/forgotPassword');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.deepOrange)
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 28),
            Text(
              "Or Login with",
              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            _socialButtons()
          ],
        ));
  }
}

GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: CircleAvatar(
      maxRadius: 24,
      backgroundColor: Colors.transparent,
      child: Image.asset(assetIcon),
    ),
  );
}
