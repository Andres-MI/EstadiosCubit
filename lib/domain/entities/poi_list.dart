import 'package:equatable/equatable.dart';
import 'package:turistic_poi_test/domain/entities/poi.dart';

//ignore: must_be_immutable
class PoiList extends Equatable{
  PoiList({
    required this.list,});

  List<Poi> list;

  @override
  List<Object?> get props => [list];
}