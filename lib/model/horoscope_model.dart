import 'base_model.dart';

class HoroscopeModel extends BaseModel<HoroscopeModel> {
  String name;
  String imageUrl;
  String property;

  HoroscopeModel({this.name, this.imageUrl, this.property});

  HoroscopeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['property'] = this.property;
    return data;
  }

  @override
  HoroscopeModel fromJson(Map<String, Object> json) {
    return HoroscopeModel.fromJson(json);
  }
}
