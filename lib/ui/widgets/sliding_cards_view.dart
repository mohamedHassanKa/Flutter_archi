import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';
import '../../core/hotel_list_model.dart';
import '../../core/models/hotel_data_model.dart';

class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({Key? key}) : super(key: key);

  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  late PageController pageController;
  double? pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page); //<-- add listener and set state
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: AnimatedBuilder(
          animation: pageController,
          builder: (context, child) {
            var hotelModel = Provider.of<HotelListModel>(context);
            return PageView.builder(
              itemCount: hotelModel.hotelList.length,
              controller: pageController,
              itemBuilder: (context, index) {
                List<HotelListData> hotels = hotelModel.hotelList;
                return SlidingCard(
                  hotel: hotels[index],
                  offset: pageOffset! - index,
                );
              },
            );
          }),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final HotelListData hotel;

  final double offset; //<-- How far is page from being displayed
// <-- name of the image to be displayed

  const SlidingCard({Key? key, required this.hotel, required this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08)); //<--caluclate Gaussian function

    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        //<--custom shape
        child: Column(
          children: <Widget>[
            ClipRRect(
              //<--clipping image
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                //<-- main image
                hotel.imagePath,
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: CardContent(
                //<--replace the Container with CardContent
                hotel: hotel,
                offset: gauss,
              ), //<-- will be replaced soon :)
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final HotelListData hotel;

  final double offset;

  const CardContent({Key? key, required this.hotel, required this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(18 * offset, 0),
            child: FittedBox(child: Text(hotel.titleTxt, style: Theme.of(context).textTheme.headline2)),
          ),
          const SizedBox(height: 4),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.pin_drop,
                  color: Theme.of(context).textSelectionTheme.cursorColor,
                ),
                const Text(
                  ' 2.0 km to City',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: const Text('Book Now'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {},
                ),
              ),
              const Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: Row(
                  children: <Widget>[
                    const Text(
                      '125.00 \$',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '/Night',
                      style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
