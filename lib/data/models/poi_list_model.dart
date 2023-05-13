
import 'package:turistic_poi_test/data/models/poi_model.dart';

class PoiListModel {
  PoiListModel({
      required this.list,});

  PoiListModel.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(PoiModel.fromJson(v));
      });
    }
  }
  List<PoiModel>? list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}