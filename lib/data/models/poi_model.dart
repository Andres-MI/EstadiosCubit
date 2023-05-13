class PoiModel {
  PoiModel({
      required this.id,
      required this.title,
      required this.geocoordinates,
      required this.image,});

  String? id;
  String? title;
  String? geocoordinates;
  String? image;

  PoiModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    geocoordinates = json['geocoordinates'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['geocoordinates'] = geocoordinates;
    map['image'] = image;
    return map;
  }

}