import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../widgets/naviguation_animation_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/sliding_cards_view.dart';
import '../widgets/splashy_effect.dart';

class DashboardScreen extends StatefulWidget {
  final AnimationController? animationController;

  const DashboardScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.animationController!.forward();
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                NaviguationAnimationBuild(
                  child: SearchBar(),
                  countWidget: 9,
                  animationValue: 0,
                  animationController: widget.animationController!,
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 12),
                      NaviguationAnimationBuild(
                        child: Text("Hello Alex,", style: Theme.of(context).textTheme.headline2),
                        countWidget: 9,
                        animationValue: 1,
                        animationController: widget.animationController!,
                      ),
                      const SizedBox(height: 8),
                      NaviguationAnimationBuild(
                        child: Text("Find your perfect places",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 24, color: Theme.of(context).hintColor)),
                        countWidget: 9,
                        animationValue: 1,
                        animationController: widget.animationController!,
                      ),
                      const SizedBox(height: 20),
                      NaviguationAnimationBuild(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Hotels",
                                style: TextStyle(
                                    fontSize: 24, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                            Text("View all",
                                style: TextStyle(
                                    fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        countWidget: 9,
                        animationValue: 2,
                        animationController: widget.animationController!,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                NaviguationAnimationBuild(
                  child: const SlidingCardsView(),
                  countWidget: 9,
                  animationValue: 3,
                  animationController: widget.animationController!,
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ),
        ));
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
