import 'dart:async';
import 'package:rxdart/rxdart.dart';
import './models/card_model.dart';
import './helpers/card_colors.dart';
import 'package:flutter/material.dart';

class CardListModelView extends ChangeNotifier {
  BehaviorSubject<List<CardResults>> _cardsCollection = BehaviorSubject<List<CardResults>>();
  BehaviorSubject<CardResults> _selectedCard = BehaviorSubject<CardResults>();

  late List<CardResults> _cardResults;
  // Retrieve data from Stream
  Stream<List<CardResults>> get cardList => _cardsCollection.stream;

  Stream<CardResults> get selectedCard => _selectedCard.stream;

  void initialData() async {
    _cardResults = CardModel.fromJson(initialinfo).results!;
    for (var i = 0; i < _cardResults.length; i++) {
      _cardResults[i].cardColor = CardColor.baseColors[i];
    }
    _cardsCollection.sink.add(_cardResults);
    _selectedCard.sink.add(_cardResults[0]);
  }

  void selectCard(int index) {
    _selectedCard.sink.add(_cardResults[index]);
  }

  CardListModelView() {
    initialData();
  }

  void dispose() {
    _cardsCollection.close();
    _selectedCard.close();
  }

  void addCardToList(CardResults newCard) {
    _cardResults.add(newCard);
    _cardsCollection.sink.add(_cardResults);
  }
}

var initialinfo = {
  "cardResults": [
    {
      "cardHolderName": "Joe Hattab",
      "cardNumber": "4485237981781168",
      "cardMonth": "12",
      "cardYear": "2025",
      "cardCvv": "150",
      "cardColor": null,
      "cardType": "CREDIT"
    },
    {
      "cardHolderName": "Mohamed hassan",
      "cardNumber": "5456299532332190",
      "cardMonth": "11",
      "cardYear": "2022",
      "cardCvv": "130",
      "cardColor": null,
      "cardType": "CREDIT"
    },
    {
      "cardHolderName": "Lionel Messi",
      "cardNumber": "4539887342960806",
      "cardMonth": "03",
      "cardYear": "2020",
      "cardCvv": "370",
      "cardColor": null,
      "cardType": "CREDIT"
    }
  ]
};
