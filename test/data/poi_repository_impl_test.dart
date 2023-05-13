import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:turistic_poi_test/data/datasource/poi_local_datasource.dart';
import 'package:turistic_poi_test/data/datasource/poi_remote_datasource.dart';
import 'package:turistic_poi_test/data/models/poi_list_model.dart';
import 'package:turistic_poi_test/data/models/poi_model.dart';
import 'package:turistic_poi_test/domain/entities/poi.dart';
import 'package:turistic_poi_test/domain/entities/poi_list.dart';
import 'package:turistic_poi_test/data/repositories/poi_repository_impl.dart';

class MockRemoteDataSource extends Mock implements PoiRemoteDatasource {}

class MockLocalDataSource extends Mock implements PoiLocalDataSource {}

void main() {
  late PoiRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = PoiRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  setUpAll(() {
    registerFallbackValue(PoiListModel(list: []));
  });

  group('getPois', () {
    test('should return a valid list of POIs from storage', () async {
      final mockPoiListModel = PoiListModel(list: [
        PoiModel(
            id: '1',
            title: 'Nueva Condomina',
            geocoordinates: '38.042222,-1.144722',
            image:
                'https://fastly.4sqi.net/img/general/200x200/YB5QtP2sdN8xTdERk3JUuyjKZBpjZycd_k4loEnHdd0.jpg'),
        PoiModel(
            id: '2',
            title: 'Punto 2',
            geocoordinates: '000,000',
            image:
                'https://static-s.aa-cdn.net/img/amazon/30600000033303/2005eed1c88a3f5d074a8b3bc85b63c9?v=1'),
      ]);
      final emptyList = PoiListModel(list: []);
      final expectedPoiList = PoiList(list: [
        Poi(
            id: '1',
            title: 'Nueva Condomina',
            geocoordinates: '38.042222,-1.144722',
            image:
                'https://fastly.4sqi.net/img/general/200x200/YB5QtP2sdN8xTdERk3JUuyjKZBpjZycd_k4loEnHdd0.jpg'),
        Poi(
            id: '2',
            title: 'Punto 2',
            geocoordinates: '000,000',
            image:
                'https://static-s.aa-cdn.net/img/amazon/30600000033303/2005eed1c88a3f5d074a8b3bc85b63c9?v=1'),
      ]);

      //arrange
      when(() => mockLocalDataSource.getLocalPois())
          .thenAnswer((_) async => mockPoiListModel);
      when(() => mockRemoteDataSource.getRemotePois())
          .thenAnswer((_) async => emptyList);

      //act
      final result = await repository.getPois();

      // Assert
      expect(result, equals(expectedPoiList));
      verify(() => mockLocalDataSource.getLocalPois()).called(1);
      verifyNever(() => mockRemoteDataSource.getRemotePois());
    });

    test(
        'should return a valid list of POIs from remote as there is no saved POIs',
        () async {
      final mockPoiListModel = PoiListModel(list: [
        PoiModel(
            id: '1',
            title: 'Nueva Condomina',
            geocoordinates: '38.042222,-1.144722',
            image:
                'https://fastly.4sqi.net/img/general/200x200/YB5QtP2sdN8xTdERk3JUuyjKZBpjZycd_k4loEnHdd0.jpg'),
        PoiModel(
            id: '2',
            title: 'Punto 2',
            geocoordinates: '000,000',
            image:
                'https://static-s.aa-cdn.net/img/amazon/30600000033303/2005eed1c88a3f5d074a8b3bc85b63c9?v=1'),
      ]);
      final emptyList = PoiListModel(list: []);
      final expectedPoiList = PoiList(list: [
        Poi(
            id: '1',
            title: 'Nueva Condomina',
            geocoordinates: '38.042222,-1.144722',
            image:
                'https://fastly.4sqi.net/img/general/200x200/YB5QtP2sdN8xTdERk3JUuyjKZBpjZycd_k4loEnHdd0.jpg'),
        Poi(
            id: '2',
            title: 'Punto 2',
            geocoordinates: '000,000',
            image:
                'https://static-s.aa-cdn.net/img/amazon/30600000033303/2005eed1c88a3f5d074a8b3bc85b63c9?v=1'),
      ]);

      //arrange
      when(() => mockLocalDataSource.getLocalPois())
          .thenAnswer((_) async => emptyList);

      when(() => mockRemoteDataSource.getRemotePois())
          .thenAnswer((_) async => mockPoiListModel);

      when(() => mockLocalDataSource.cachePois(any()))
          .thenAnswer((_) async => Future.value(null));

      //act
      final result = await repository.getPois();

      // Assert
      expect(result, equals(expectedPoiList));
      verify(() => mockLocalDataSource.getLocalPois()).called(1);
      verify(() => mockRemoteDataSource.getRemotePois()).called(1);
    });

  });
}
