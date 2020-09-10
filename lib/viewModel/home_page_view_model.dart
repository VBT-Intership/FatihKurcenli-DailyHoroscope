import 'package:flutter/material.dart';

import '../model/horoscope_model.dart';
import '../service/Horoscope_service.dart';
import '../service/IHoroscope_service.dart';
import '../view/home_page.dart';

abstract class HomePageViewModel extends State<HomePage> {
  List<HoroscopeModel> horoscope = [];
  IHoroscope horoscopeService;

  @override
  void initState() {
    super.initState();
    horoscopeService = HoroscopeService();
    getItems();
  }

  Future<void> getItems() async {
    await _getHoroscope();
  }

  Future<void> _getHoroscope() async {
    horoscope = await horoscopeService.getList();
  }
}
