import 'package:flutter/material.dart';
import './utils/responsive_config.dart';

class ConfigManager extends StatelessWidget {
  const ConfigManager({Key? key, this.initializeConfig = false, required this.builder}) : super(key: key);

  final bool initializeConfig;

  final Widget Function(BuildContext context, LayoutConfig layoutConfig) builder;

  @override
  Widget build(BuildContext context) {
    final LayoutConfig layoutConfig = LayoutConfig();
    if (initializeConfig) {
      layoutConfig.init(context);
    }
    return builder(context, layoutConfig);
  }
}
