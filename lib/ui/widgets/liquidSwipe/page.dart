import 'package:flutter/material.dart';

/// This is the class which contains the Page UI.
class PageStack extends StatelessWidget {
  ///page details
  final Container pageView;

  //Constructor
  PageStack({
    Key? key,
    required this.pageView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        pageView,
      ],
    );
  }
}
