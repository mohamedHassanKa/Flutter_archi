import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseViewModelWidget<T> extends StatefulWidget {
  const BaseViewModelWidget({
    Key? key,
    this.onModelReady,
    required this.builder,
  }) : super(key: key);

  final void Function(T provider)? onModelReady;
  final Widget Function(BuildContext context, T provider) builder;

  @override
  _BaseViewModelWidgetState<T> createState() => _BaseViewModelWidgetState<T>();
}

class _BaseViewModelWidgetState<T> extends State<BaseViewModelWidget<T>> {
  late T _provider;

  @override
  void initState() {
    super.initState();
    if (widget.onModelReady != null) {
      _provider = Provider.of<T>(context, listen: false);
      widget.onModelReady!(_provider);
    }
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<T>(context);
    return DismissKeyboardWidget(
      child: widget.builder(context, _provider),
    );
  }
}

class DismissKeyboardWidget extends StatelessWidget {
  const DismissKeyboardWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: child,
      ),
    );
  }
}
