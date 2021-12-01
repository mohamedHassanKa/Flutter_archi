import 'package:flutter/material.dart';
import '../Clippers/CircularWave.dart';
import '../Constants/Helpers.dart';

import '../Clippers/wave_layer.dart';

/// This class reveals the next page in the liquid wave form.

class PageReveal extends StatelessWidget {
  final double? revealPercent;
  final Widget child;
  final SlideDirection? slideDirection;
  final double? iconPosition;
  final WaveType? waveType;
  final double? vertReveal;

  //Constructor
  PageReveal(
      {this.revealPercent,
      required this.child,
      this.slideDirection,
      this.iconPosition,
      this.waveType,
      this.vertReveal});

  @override
  Widget build(BuildContext context) {
    //ClipPath clips our Container (page) with clipper based on path..
    switch (waveType) {
      case WaveType.liquidReveal:
        return ClipPath(
          clipper: WaveLayer(
              revealPercent: slideDirection == SlideDirection.leftToRight
                  ? 1.0 - revealPercent!
                  : revealPercent!,
              slideDirection: slideDirection!,
              iconPosition: iconPosition!,
              verReveal: slideDirection == SlideDirection.leftToRight
                  ? vertReveal! + 0.25
                  : vertReveal!),
          child: child,
        );

      case WaveType.circularReveal:
        return ClipPath(
          clipper: CircularWave(
              iconPosition!,
              slideDirection == SlideDirection.leftToRight
                  ? 1.0 - revealPercent!
                  : revealPercent!,
              vertReveal!),
          child: child,
        );

      default:
        return ClipPath(
          clipper: WaveLayer(
              revealPercent: slideDirection == SlideDirection.leftToRight
                  ? 1.0 - revealPercent!
                  : revealPercent!,
              slideDirection: slideDirection!,
              iconPosition: iconPosition!,
              verReveal: vertReveal!),
          child: child,
        );
    }
  }
}
