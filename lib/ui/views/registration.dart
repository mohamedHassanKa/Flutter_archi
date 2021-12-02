import 'package:flutter/material.dart';
import '../widgets/bottom_curve_painter.dart';
import '../widgets/gradient_text.dart';

//import 'HomeView.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  _textAccount(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  registerFields(context)
                ],
              ),
            )
          ]),
        ));
  }

  GradientText _loginGradientText(context) {
    return GradientText('Register',
        gradient: LinearGradient(
            colors: [Theme.of(context).primaryColor, const Color(0xFF68D8D6)]),
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 42));
  }

  Widget _textAccount(context) {
    return FittedBox(
      child: Row(
        children: <Widget>[
          Text(
            "Have you registred already? ",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text("Login Here .",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.deepOrange)
                  .copyWith(fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  registerFields(context) => Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                            blurRadius: 20.0,
                            offset: const Offset(0, 10))
                      ]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade100))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Name",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade100))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Email",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade100))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Password",
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade100)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
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
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const SizedBox(height: 8),
          Text(
            "Or Sign Up with",
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 12),
          _socialButtons()
        ],
      ));

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
}
