import 'package:turistic_poi_test/domain/entities/poi_list.dart';

import '../../data/models/poi_list_model.dart';

/// The repository interface for POI (Point of Interest).
///
/// This interface defines the methods to interact with POI data, including
/// fetching POI list, saving POI list, and deleting the stored POI list.
abstract class PoiRepository {
  /// Retrieves the list of POIs.
  ///
  /// Returns a [Future] that resolves to a [PoiList] object containing the
  /// list of POIs.
  Future<PoiList> getPois();

  /// Saves the given [list] of POIs.
  ///
  /// This method persists the provided [list] of POIs in the storage.
  ///
  /// Parameters:
  /// - [list]: The [PoiListModel] representing the list of POIs to be saved.
  ///
  /// Returns:
  /// A [Future] representing the completion of the saving operation.
  Future<void> savePoiList(PoiListModel list);


  void deletePoiList();
}