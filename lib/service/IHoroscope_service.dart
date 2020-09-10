import 'package:horoscope/model/horoscope_model.dart';

abstract class IHoroscope {
  Future<List<HoroscopeModel>> getList();
}
