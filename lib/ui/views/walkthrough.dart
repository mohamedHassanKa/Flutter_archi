import 'package:flutter/material.dart';
import '../widgets/liquidSwipe/Constants/Helpers.dart';
import '../widgets/liquidSwipe/liquid_swipe.dart';
import '../shared/text_styles.dart' as style;
import 'package:flutter/cupertino.dart';

class Walkthrough extends StatelessWidget {
  Walkthrough({Key? key}) : super(key: key);
  final colors = [
    Colors.white,
    const Color(0xFF60D0E4),
    const Color(0xFF7C4DF3)
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Vacation Rentals',
                      style: style.headline.copyWith(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'SKIP',
                        style: style.headline.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.asset('assets/1.jpg',
                    height: size.height * 0.4, width: size.width * 0.8),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Trip',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 42,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Planning',
                      style: style.display1.copyWith(fontSize: 48),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Lorem Ipsum Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                      style: style.body1.copyWith(color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Container(
          color: const Color(0xFF60D0E4),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Vacation Rentals',
                        style: style.headline.copyWith(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'SKIP',
                          style: style.headline.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Image.asset('assets/3.png',
                      height: size.height * 0.4, width: size.width * 0.8),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Enjoy',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 42,
                            color: const Color(0xFFFFFCEB).withOpacity(0.7)),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Vacation',
                        style: style.display1.copyWith(
                            fontSize: 48, color: const Color(0xFFFFFCEB)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Lorem Ipsum Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                        style: style.body1.copyWith(
                            color: const Color(0xFFFFFCEB).withOpacity(0.7)),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
      Container(
        color: const Color(0xFF7C4DF3),
        child: Center(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Vacation Rentals',
                        style: style.headline
                            .copyWith(fontSize: 18, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'SKIP',
                          style: style.headline.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Image.asset('assets/2.png',
                      height: size.height * 0.4, width: size.width * 0.8),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Best',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 42,
                            color: const Color(0xFFFE7C94).withOpacity(0.6)),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FittedBox(
                        child: Text(
                          'Travelling',
                          style: style.display1.copyWith(
                              fontSize: 48, color: const Color(0xFFFE6083)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Lorem Ipsum Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                        style: style.body1.copyWith(
                            color: const Color(0xFFFE7C94).withOpacity(0.6)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ];
    pageChangeCallback(int page) {
      print(page);
    }

    updateTypeCallback(UpdateType updateType) {
      //print(updateType);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LiquidSwipe(
        colors: colors,
        pages: pages,
        fullTransitionValue: 700,
        enableLoop: true,
        enableSlideIcon: false,
        positionSlideIcon: 0.65,
        waveType: WaveType.liquidReveal,
        onPageChangeCallback: (page) => pageChangeCallback(page),
        currentUpdateTypeCallback: (updateType) =>
            updateTypeCallback(updateType),
      ),
    );
  }
}
