import 'package:flutter/foundation.dart';
import 'package:turistic_poi_test/data/datasource/poi_local_datasource.dart';
import 'package:turistic_poi_test/data/datasource/poi_remote_datasource.dart';
import 'package:turistic_poi_test/data/models/poi_list_model.dart';
import 'package:turistic_poi_test/domain/entities/poi.dart';
import 'package:turistic_poi_test/domain/entities/poi_list.dart';
import 'package:turistic_poi_test/domain/repositories/poi_repository.dart';

import 'models/poi_model.dart';

class PoiRepositoryImpl implements PoiRepository {
  final PoiRemoteDatasource remoteDataSource;
  final PoiLocalDataSource localDataSource;

  PoiRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<PoiList> getPois() async {
    //Solicitamos los POI a los datasources, verificando antes si existen en BBDD o si hay que pedirlos a remoto y guardarlos
    try {
      var poiList = await localDataSource.getLocalPois();
      if (poiList.list?.isEmpty ?? true) {
        poiList = await remoteDataSource.getRemotePois();
        savePoiList(poiList);
      }
      if(poiList.list?.isNotEmpty ?? false){
        return mapperToEntity(model: poiList);
      } else {
        throw Exception('La lista de POIs está vacía.');
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<void> savePoiList(PoiListModel list) async {
    localDataSource.cachePois(list);
  }

  //Mapeamos de modelo a entidad para entrar a la capa de dominio
  PoiList mapperToEntity({required PoiListModel model}) {
     List<Poi>? listOfPoi = model.list?.map((poiModel) => Poi(
        id: poiModel.id ?? '0',
        title: poiModel.title ?? '',
        geocoordinates: poiModel.geocoordinates ?? '',
        image: poiModel.image ?? '')).toList();

    return PoiList(list: listOfPoi!);
  }

  //Mapeamos de entidad a modelo para volver a la capa de datos
  PoiListModel mapperToModel({required PoiList entity}) {
    List<PoiModel> listOfPoi = entity.list.map((poiEntity) => PoiModel(
        id: poiEntity.id,
        title: poiEntity.title,
        geocoordinates: poiEntity.geocoordinates,
        image: poiEntity.image)).toList();

    return PoiListModel(list: listOfPoi);
  }
}
