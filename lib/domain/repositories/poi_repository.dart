import 'package:turistic_poi_test/domain/entities/poi_list.dart';

import '../../data/models/poi_list_model.dart';

abstract class PoiRepository {
  Future<PoiList> getPois();
  Future<void> savePoiList(PoiListModel list);
}