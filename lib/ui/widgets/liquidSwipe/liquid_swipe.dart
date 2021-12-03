import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './Animation_Gesture/animated_page_dragger.dart';
import './Animation_Gesture/page_dragger.dart';
import './page.dart';

import 'Animation_Gesture/page_reveal.dart';
import './Clippers/wave_layer.dart';
import 'Constants/Helpers.dart';

final key = GlobalKey<_LiquidSwipe>();

typedef OnPageChangeCallback = void Function(int activePageIndex);
typedef CurrentUpdateTypeCallback = void Function(UpdateType updateType);

class LiquidSwipe extends StatefulWidget {
  final List<Container> pages;
  final List<Color> colors;

  final double fullTransitionValue;
  final int initialPage;
  final bool enableSlideIcon;
  final Widget slideIconWidget;
  final double positionSlideIcon;
  final bool enableLoop;
  final WaveType waveType;

  final OnPageChangeCallback? onPageChangeCallback;
  final CurrentUpdateTypeCallback? currentUpdateTypeCallback;

  LiquidSwipe({
    Key? key,
    required this.pages,
    required this.colors,
    this.fullTransitionValue = FULL_TARNSITION_PX,
    this.initialPage = 0,
    this.enableSlideIcon = false,
    this.slideIconWidget = const Icon(Icons.arrow_back_ios),
    this.positionSlideIcon = 0.54,
    this.enableLoop = true,
    this.waveType = WaveType.liquidReveal,
    this.onPageChangeCallback,
    this.currentUpdateTypeCallback,
  })  : assert(pages != null),
        assert(onPageChangeCallback != null),
        assert(fullTransitionValue != null),
        assert(initialPage != null && initialPage >= 0 && initialPage < pages.length),
        assert(positionSlideIcon >= -1 && positionSlideIcon <= 1),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LiquidSwipe();
}

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercentHor, slidePercentVer;

  SlideUpdate(
    this.direction,
    this.slidePercentHor,
    this.slidePercentVer,
    this.updateType,
  );
}

class _LiquidSwipe extends State<LiquidSwipe> with TickerProviderStateMixin {
  StreamController<SlideUpdate>? slideUpdateStream; //Stream controller is used to get all the updates when user slides across screen.

  AnimatedPageDragger? animatedPageDragger; //When user stops dragging then by using this page automatically drags.

  int activePageIndex = 0; //active page index
  int nextPageIndex = 0; //next page index
  SlideDirection slideDirection = SlideDirection.none; //slide direction
  double? slidePercentHor, slidePercentVer = 0.0; //slide percentage (0.0 to 1.0)
  StreamSubscription<SlideUpdate>? slideUpdateStream$;
  UpdateType? prevUpdate;
  bool finishScroll = true;

  set setActivePageIndex(int value) {
    activePageIndex = value;

    widget.onPageChangeCallback!(activePageIndex);
  }

  @override
  void initState() {
    slidePercentHor = slidePercentVer = 10;
    activePageIndex = widget.initialPage;
    nextPageIndex = widget.initialPage;
    //Stream Controller initialization
    slideUpdateStream = StreamController<SlideUpdate>();
    //listening to updates of stream controller
    //finishScroll = false;

    slideUpdateStream$ = slideUpdateStream!.stream.listen((SlideUpdate event) {
      setState(() {
        finishScroll = false;
        //send the current update type through a callback
        if (prevUpdate != event.updateType) widget.currentUpdateTypeCallback!(event.updateType);

        prevUpdate = event.updateType;
        //setState is used to change the values dynamically
        //if the user is dragging then
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercentHor = event.slidePercentHor;
          slidePercentVer = event.slidePercentVer;

          // making pages to be in loop
          if (widget.enableLoop) {
            //conditions on slide direction
            if (slideDirection == SlideDirection.leftToRight) {
              nextPageIndex = activePageIndex - 1;
            } else if (slideDirection == SlideDirection.rightToLeft) {
              nextPageIndex = activePageIndex + 1;
            } else {
              nextPageIndex = activePageIndex;
            }

            if (nextPageIndex > widget.pages.length - 1)
              nextPageIndex = 0;
            else if (nextPageIndex < 0) nextPageIndex = widget.pages.length - 1;
          } else {
            //conditions on slide direction
            if (slideDirection == SlideDirection.leftToRight && activePageIndex != 0) {
              nextPageIndex = activePageIndex - 1;
            } else if (slideDirection == SlideDirection.rightToLeft && activePageIndex != widget.pages.length - 1) {
              nextPageIndex = activePageIndex + 1;
            } else {
              nextPageIndex = activePageIndex;
            }
          }
        }
        //if the user has done dragging
        else if (event.updateType == UpdateType.doneDragging) {
          // slidepercent > 0.2 so that it wont reveal itself unless this condition is true
          if (slidePercentHor! > 0.2) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercentHor: slidePercentHor!,
              slidePercentVer: slidePercentVer!,
              slideUpdateStream: slideUpdateStream!,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercentHor: slidePercentHor!,
              slidePercentVer: slidePercentVer!,
              slideUpdateStream: slideUpdateStream!,
              vsync: this,
            );

            nextPageIndex = activePageIndex;
          }
          //Run the animation
          animatedPageDragger!.run();
        }
        //when animating
        else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercentHor = event.slidePercentHor;
          slidePercentVer = event.slidePercentVer;
        }
        //done animating
        else if (event.updateType == UpdateType.doneAnimating) {
          finishScroll = true;
          activePageIndex = nextPageIndex;
          widget.onPageChangeCallback!(activePageIndex);
          slideDirection = SlideDirection.none;
          slidePercentHor = 0.5;
          slidePercentVer = widget.positionSlideIcon;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    slideUpdateStream$?.cancel();
    animatedPageDragger?.dispose();
    slideUpdateStream?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Container> pages = widget.pages;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          slideDirection == SlideDirection.leftToRight
              ? pages[activePageIndex]
              : !finishScroll
                  ? pages[nextPageIndex]
                  : Container(
                      color: widget.colors[nextPageIndex + 1 >= widget.pages.length ? 0 : nextPageIndex + 1],
                      child: ClipPath(
                        clipper: WaveLayer(revealPercent: 0.01, verReveal: 1.25),
                        child: PageStack(
                          pageView: pages[nextPageIndex],
                        ),
                      ),
                    ),

          //Pages
          PageReveal(
            //next page reveal
            revealPercent: slidePercentHor!,
            child: PageStack(pageView: slideDirection == SlideDirection.leftToRight ? pages[nextPageIndex] : pages[activePageIndex]),
            slideDirection: slideDirection,
            iconPosition: widget.positionSlideIcon,

            waveType: widget.waveType,
            vertReveal: slidePercentVer!,
          ),
          PageDragger(
            //Used for gesture control
            fullTransitionPX: widget.fullTransitionValue,
            slideUpdateStream: this.slideUpdateStream,
            enableSlideIcon: widget.enableSlideIcon,
            slideIconWidget: widget.slideIconWidget,
            iconPosition: widget.positionSlideIcon,
          ), //PageDragger
        ], //Widget
      ), //Stack
    ); //Scaffold
  }
}
