import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/poi_list_model.dart';

/// Interface for caching and retrieving POIs from a local data source.
abstract class PoiLocalDataSource {

  /// Retrieves the locally cached POIs.
  ///
  /// Returns a [Future] that resolves to a [PoiListModel] containing the cached list of POIs.
  ///
  /// Throws an [Exception] if an error occurs during the data retrieval process.
  Future<PoiListModel> getLocalPois();

  /// Caches the provided [poList] of POIs in the local data source.
  ///
  /// Returns a [Future] that completes once the caching process is finished.
  ///
  /// Throws an [Exception] if an error occurs during the caching process.
  Future<void> cachePois(PoiListModel poList);
}

class PoiLocalDataSourceImpl implements PoiLocalDataSource {

  static const String keyParameter = "POI_SAVED";

  //Se ha utilizado SharedPefrences por cumplir con la función y por simplicidad.
  //Estaría optimizado para poder cambiarlo en un futuro a una BBDD más compleja
  //Simplemente cambiando esta clase (y su inyección)
  final Future <SharedPreferences> sharedPreferences;

  PoiLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cachePois(PoiListModel poiList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyParameter, json.encode(poiList.toJson()));
  }

  @override
  Future<PoiListModel> getLocalPois() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      return PoiListModel.fromJson(json.decode(prefs.getString(keyParameter) ?? ''));
    } on Exception catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
      return PoiListModel(list: []);
    }

  }

}

