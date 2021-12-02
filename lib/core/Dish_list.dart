import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FoodList extends ChangeNotifier {
  List categories = [
    {
      "id": "1",
      "type": "Pizza",
      "img": "assets/food1.jpg",
      "cuisine": "Italien",
      "rating" : 5.0,
      "liked" : true,
      "price" : 248,
      "imgList": ["assets/food1.jpg", "assets/food2.jpg", "assets/food3.jpg"]
    },
    {
      "id": "2",
      "type": "Pasta",
      "img": "assets/food2.jpg",
      "cuisine": "Italien",
      "rating" : 5.0,
      "liked" : false,
      "price" : 48,
      "imgList": ["assets/food2.jpg", "assets/food4.jpg", "assets/food5.jpg"]


    },
    {
      "id": "3",
      "type": "Sweet and Sour Pork",
      "img": "assets/food3.jpg",
      "cuisine": "Chinese",
      "rating" : 3.5,
      "liked": true,
      "price" : 485,
      "imgList": ["assets/food3.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "4",
      "type": "Dumplings",
      "img": "assets/food4.jpg",
      "cuisine": "Chinese",
    "rating" : 4.5,
      "liked" : false,
      "price" : 481,
      "imgList": ["assets/food4.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "5",
      "type": "Spring Rolls",
      "img": "assets/food5.jpg",
      "cuisine": "Chinese",
    "rating" : 2.5,
      "liked" : true,
      "price" : 482,
      "imgList": ["assets/food5.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "6",
      "type": "Bibimbap",
      "img": "assets/food6.jpg",
      "cuisine": "Korean",
      "rating" : 5.0,
      "liked" : true,
      "price" : 483,
      "imgList": ["assets/food6.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "7",
      "type": "Bulgogi",
      "img": "assets/food7.jpg",
      "cuisine": "Korean",
      "rating" : 5.0,
      "liked" : true,
      "price" : 4,
      "imgList": ["assets/food7.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "8",
      "type": "Japchae ",
      "img": "assets/food8.jpg",
      "cuisine": "Korean",
      "rating" : 5.0,
      "liked" : true,
      "price" : 488,
      "imgList": ["assets/food8.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "9",
      "type": "Tacos al pastor",
      "img": "assets/food9.jpg",
      "cuisine": "Mexican",
      "rating" : 5.0,
      "liked" : true,
      "price" : 999,
      "imgList": ["assets/food9.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "10",
      "type": "Tyler's Flan",
      "img": "assets/food10.jpg",
      "cuisine": "Mexican",
      "rating" : 5.0,
      "liked" : true,
      "price" : 78,
      "imgList": ["assets/food10.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "11",
      "type": "Chiles Rellenos.",
      "img": "assets/food11.jpg",
      "cuisine": "Mexican",
      "rating" : 5.0,
      "liked" : true,
      "price" : 55,
      "imgList": ["assets/food11.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "12",
      "type": "Hamburger",
      "img": "assets/food12.jpg",
      "cuisine": "Americain",
      "rating" : 5.0,
      "liked" : true,
      "price" : 16,
      "imgList": ["assets/food12.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "13",
      "type": "Apple Pie",
      "img": "assets/food13.jpg",
      "cuisine": "Americain",
      "rating" : 5.0,
      "liked" : true,
      "price" : 48,
      "imgList": ["assets/food13.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
    {
      "id": "14",
      "type": "Steak",
      "img": "assets/food14.jpg",
      "cuisine": "Americain",
      "rating" : 5.0,
      "liked" : true,
      "price" : 666,
      "imgList": ["assets/food14.jpg", "assets/food2.jpg", "assets/food3.jpg"]

    },
  ];

  List cuisines = [
    {
      "id": "1",
      "cuisine": "Chinese",
      "img": "assets/food1.jpg",
    },
    {
      "id": "2",
      "cuisine": "Korean",
      "img": "assets/food2.jpg",
    },
    {
      "id": "3",
      "cuisine": "Americain",
      "img": "assets/food3.jpg",
    },
    {
      "id": "4",
      "cuisine": "Mexicain",
      "img": "assets/food4.jpg",
    },
    {
      "id": "5",
      "cuisine": "Italien",
      "img": "assets/food5.jpg",
    },

  ];
  likeAndUnlike(id){
    categories.forEach((categorie)  {
      if(categorie['id'] == id){
        categorie['liked'] = !categorie['liked'];
      }
    }  ) ;
    notifyListeners() ;
  }
}
