import 'package:flutter/material.dart';

class SplashySplash extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final Color color;
  const SplashySplash({
    Key? key,
    required this.child,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  _SplashySplashState createState() => _SplashySplashState();
}

class _SplashySplashState extends State<SplashySplash>
    with SingleTickerProviderStateMixin {
  static const double minRadius = 80;
  static const double maxRadius = 80;

  AnimationController? controller;
  Tween<double>? radiusTween;
  Tween<double>? borderWidthTween;
  Animation<double>? radiusAnimation;
  Animation<double>? borderWidthAnimation;
  AnimationStatus? status;
  Offset? _tapPosition;
  RenderBox? renderBox;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((listener) {
        status = listener;
      });
    radiusTween = Tween<double>(begin: 0, end: 50);
    radiusAnimation = radiusTween!
        .animate(CurvedAnimation(curve: Curves.ease, parent: controller!));
    borderWidthTween = Tween<double>(begin: 25, end: 1);
    borderWidthAnimation = borderWidthTween!.animate(
        CurvedAnimation(curve: Curves.fastOutSlowIn, parent: controller!));

    super.initState();
  }

  void _animate() {
    controller!.forward(from: 0);
  }

  void _handleTap(TapUpDetails tapDetails) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    _tapPosition = renderBox.globalToLocal(tapDetails.globalPosition);
    double radius = (renderBox.size.width > renderBox.size.height)
        ? renderBox.size.width
        : renderBox.size.height;
    double constraintRadius;
    if (radius > maxRadius) {
      constraintRadius = maxRadius;
    } else if (radius < minRadius) {
      constraintRadius = minRadius;
    } else {
      constraintRadius = radius;
    }

    radiusTween!.end = constraintRadius * 0.6;
    borderWidthTween!.begin = radiusTween!.end! / 2;
    borderWidthTween!.end = radiusTween!.end! * 0.01;
    _animate();

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: SplashPaint(
        radius: radiusAnimation!.value,
        borderWidth: borderWidthAnimation!.value,
        status: status,
        tapPosition: _tapPosition,
        color: widget.color.withOpacity(0.7),
      ),
      child: GestureDetector(
        child: widget.child,
        onTapUp: _handleTap,
      ),
    );
  }
}

class SplashPaint extends CustomPainter {
  final double radius;
  final double borderWidth;
  final AnimationStatus? status;
  final Offset? tapPosition;
  final Paint blackPaint;
  final Color color;

  SplashPaint(
      {required this.radius,
      required this.borderWidth,
      this.status,
      this.tapPosition,
      required this.color})
      : blackPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (status == AnimationStatus.forward) {
      canvas.drawCircle(tapPosition!, radius, blackPaint);
    }
  }

  @override
  bool shouldRepaint(SplashPaint oldDelegate) {
    if (radius != oldDelegate.radius) {
      return true;
    } else {
      return false;
    }
  }
}
