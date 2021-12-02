import 'package:flutter/material.dart';

class NaviguationAnimationBuild extends StatefulWidget {
  final AnimationController animationController;
  final int animationValue;
  final Widget child;

  final int countWidget;

  NaviguationAnimationBuild(
      {Key? key,
      required this.child,
      required this.animationController,
      this.countWidget = 9,
      this.animationValue = 0})
      : super(key: key);

  @override
  _NaviguationAnimationBuildState createState() =>
      _NaviguationAnimationBuildState();
}

class _NaviguationAnimationBuildState extends State<NaviguationAnimationBuild> {
  late Animation<double> animation;

  @override
  void initState() {
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval((1 / widget.countWidget) * widget.animationValue, 1.0,
            curve: Curves.fastOutSlowIn)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: widget.child,
          ),
        );
      },
    );
  }
}
