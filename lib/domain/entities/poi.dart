import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Poi extends Equatable{
  Poi({
    required this.id,
    required this.title,
    required this.geocoordinates,
    required this.image,});

  String id;
  String title;
  String geocoordinates;
  String image;

  @override
  List<Object?> get props => [id, title, geocoordinates, image];
}