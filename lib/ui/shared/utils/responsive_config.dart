import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

///this class contain the basic configuration of an app
@singleton
class LayoutConfig {
  late MediaQueryData _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;
  late double _devicePixelRatio;
  double? _fractionSize;
  TargetPlatform? _targetPlatform;
  String? _baseUrl;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double? get fractionSize => _fractionSize;

  double get devicePixelRatio => _devicePixelRatio;

  TargetPlatform? get targetPlatform => _targetPlatform;

  String? get baseUrl => _baseUrl;

  ///this method initialize all of our attributes

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _devicePixelRatio = _mediaQueryData.devicePixelRatio;
    _targetPlatform = Theme.of(context).platform;
  }

  double getResponsiveItemSize(double value) => screenWidth * (value / 375);

  double getHeightResponsiveItemSize(double value) => screenHeight * (value / 812);
}
