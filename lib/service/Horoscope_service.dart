import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/base_model.dart';
import '../model/error_model.dart';
import '../model/horoscope_model.dart';
import 'IHoroscope_service.dart';

class HoroscopeService extends IHoroscope {
  final baseUrl = "https://horoscope-intern.firebaseio.com/";

  @override
  Future<List<HoroscopeModel>> getList() async {
    return await _httpGet<HoroscopeModel>(
        "$baseUrl/horoscope.json", HoroscopeModel());
  }

  Future<dynamic> _httpGet<T extends BaseModel>(String path, T model) async {
    try {
      final response = await http.get(path);
      if (response is http.Response) {
        switch (response.statusCode) {
          case HttpStatus.ok:
            return _parseBody<T>(response.body, model);
            break;
          default:
            throw ErrorModel(response.body);
        }
      }
    } catch (e) {
      return ErrorModel(e);
    }
  }

  dynamic _parseBody<T extends BaseModel>(String body, BaseModel model) {
    final jsonBody = jsonDecode(body);
    if (jsonBody is List) {
      return jsonBody.map((e) => model.fromJson(e)).cast<T>().toList();
    } else if (jsonBody is Map) {
      return model.fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  }
}
