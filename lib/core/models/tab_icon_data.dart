import 'package:flutter/material.dart';

class TabIconData {
  String imagePath;
  String selctedImagePath;
  bool isSelected;
  int index;
  AnimationController? animationController;

  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selctedImagePath = "",
    this.isSelected = false,
    this.animationController,
  });

  static List<TabIconData> tabIconsList = [
    TabIconData(
      imagePath: 'assets/tab_bar_home.svg',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/tab_bar_messages.svg',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/tab_bar_notifications.svg',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/tab_bar_profile.svg',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
