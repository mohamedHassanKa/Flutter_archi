import 'dart:convert';
import 'dart:ffi';

import 'package:archi/core/models/common_models/error_model.dart';
import 'package:flutter/material.dart';

import '../models/hotel_data_model.dart';
import 'package:injectable/injectable.dart';
import '../services/http_invote_api.dart';
import '../models/common_models/api_result_model.dart';
import '../../ui/shared/locator_setup/locator.dart';
import './base_provider.dart';

@injectable
class HotelListProvider extends BaseProvider {
  static final List<HotelListData> _hotelList = [
    HotelListData(
      imagePath: 'assets/hotel1.jpg',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    HotelListData(
      imagePath: 'assets/hotel2.jpg',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'assets/hotel3.jpg',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    HotelListData(
      imagePath: 'assets/hotel4.jpg',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    HotelListData(
      imagePath: 'assets/hotel5.jpg',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'assets/hotel6.jpg',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
  ];
  List<HotelListData> get hotelList => _hotelList;
  final HttpInvokeApi _http = locator<HttpInvokeApi>();

  Future<ApiResultModel> tryPrint() async {
    setBusy(true);
    ApiResultModel call = await _http.getWS(uri: 'posts');
    setBusy(false);
    return call.when(
      success: (success) {
        //print(success);
        final dynamic decodeJson = jsonDecode(success.body);
        return ApiResultModel.success(data: decodeJson);
      },
      failure: (failure) {
        //print(failure);
        return ApiResultModel.failure(errorModel: failure);
      },
    );
  }
}
