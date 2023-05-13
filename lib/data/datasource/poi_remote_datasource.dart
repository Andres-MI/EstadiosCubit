import 'package:dio/dio.dart';
import 'package:turistic_poi_test/data/models/poi_list_model.dart';

/// Interface for fetching POIs from a remote data source.
abstract class PoiRemoteDatasource {

  /// Fetches the POIs from a remote data source.
  ///
  /// Returns a [Future] that resolves to a [PoiListModel] containing the list of POIs.
  ///
  /// Throws an [Exception] if an error occurs during the data fetching process.
  Future<PoiListModel> getRemotePois();

}

class PoiRemoteDataSourceImpl implements PoiRemoteDatasource {
  final Dio client;
  static const String url = 'https://sergiocasero.es/pois.json';

  PoiRemoteDataSourceImpl({required this.client});

  @override
  Future<PoiListModel> getRemotePois() async{
    try{
      final response = await client.get(url);
      if(response.statusCode == 200){
        return PoiListModel.fromJson((response.data));
      } else {
        throw Exception('Server Exception');
      }
    }on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}