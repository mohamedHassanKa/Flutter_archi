import 'package:archi/ui/shared/utils/responsive_config.dart';
import 'package:flutter/material.dart';
import '../../shared/config_manager.dart';

class BlockingLoadingIndicator extends StatelessWidget {
  const BlockingLoadingIndicator({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConfigManager(
      builder: (BuildContext _, LayoutConfig config) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
            if (isLoading)
              AnimatedOpacity(
                opacity: isLoading ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: config.screenWidth,
                  height: config.screenHeight,
                  color: Colors.white.withOpacity(0.25),
                  child: const Center(
                    child: Text("Loading ..."),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
