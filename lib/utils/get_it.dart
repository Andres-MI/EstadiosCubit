import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import '../data/datasource/poi_local_datasource.dart';
import '../data/datasource/poi_remote_datasource.dart';
import '../data/repositories/poi_repository_impl.dart';
import '../presentation/cubit/poi_cubit.dart';

class DependencyInjector {
  final locator = GetIt.instance;

  void setup(){
    locator.registerLazySingleton<PoiRemoteDataSourceImpl>(() => PoiRemoteDataSourceImpl(client: Dio()));
    locator.registerLazySingleton<PoiLocalDataSourceImpl>(() => PoiLocalDataSourceImpl(sharedPreferences: SharedPreferences.getInstance()));
    locator.registerLazySingleton<PoiRepositoryImpl>(() => PoiRepositoryImpl(
      remoteDataSource: locator<PoiRemoteDataSourceImpl>(),
      localDataSource: locator<PoiLocalDataSourceImpl>(),
    ));

    locator.registerFactory<PoiCubit>(() => PoiCubit(locator<PoiRepositoryImpl>()));
  }
}