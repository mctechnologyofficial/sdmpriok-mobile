import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_slider.dart';

class SliderProvider extends ChangeNotifier {
  List<ResponseGetSlider> _data = [];

  List<ResponseGetSlider> get dataSlider => _data;

  Future<List<ResponseGetSlider>> getSliders() async {
    final url = 'https://humancapitalpriokpomu.com/api/slide/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("RespGetSlider : " + response.body);
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result
          .map<ResponseGetSlider>((json) => ResponseGetSlider.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
