import 'package:flutter/material.dart';

const Color notWhite = Color(0xFFEDF0F2);
const Color nearlyWhite = Color(0xFFFEFEFE);
const Color white = Color(0xFFFFFFFF);
const Color nearlyBlack = Color(0xFF213333);
const Color grey = Color(0xFF3A5160);
const Color dark_grey = Color(0xFF313A44);

const Color darkText = Color(0xFF253840);
const Color darkerText = Color(0xFF17262A);
const Color lightText = Color(0xFF4A6572);
const Color deactivatedText = Color(0xFF767676);
const Color dismissibleBackground = Color(0xFF364A54);
const Color chipBackground = Color(0xFFEEF1F3);

const Color spacer = Color(0xFFF2F2F2);
const String fontName = 'WorkSans';
const TextTheme textTheme = TextTheme(
  headline1: display1,
  headline2: headline,
  headline3: title,
  headline4: subtitle,
  headline5: body2,
  headline6: body1,
  caption: caption,
);

const TextStyle display1 = TextStyle(
  // h4 -> display1
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: 36,
  letterSpacing: 0.4,
  height: 0.9,
);

const TextStyle headline = TextStyle(
  // h5 -> headline
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: 24,
  letterSpacing: 0.27,
);

const TextStyle title = TextStyle(
  // h6 -> title
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: 16,
  letterSpacing: 0.18,
);

const TextStyle subtitle = TextStyle(
  // subtitle2 -> subtitle
  fontFamily: fontName,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  letterSpacing: -0.04,
);

const TextStyle body2 = TextStyle(
  // body1 -> body2
  fontFamily: fontName,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  letterSpacing: 0.2,
);

const TextStyle body1 = TextStyle(
  // body2 -> body1
  fontFamily: fontName,
  fontWeight: FontWeight.w400,
  fontSize: 16,
  letterSpacing: -0.05,
);

const TextStyle caption = TextStyle(
  // Caption -> caption
  fontFamily: fontName,
  fontWeight: FontWeight.w400,
  fontSize: 12,
  letterSpacing: 0.2,
);
