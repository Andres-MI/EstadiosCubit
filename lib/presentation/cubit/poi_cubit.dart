import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:turistic_poi_test/domain/entities/poi_list.dart';

import '../../domain/repositories/poi_repository.dart';

part 'poi_state.dart';

class PoiCubit extends Cubit<PoiState> {
  PoiCubit(this._repository) : super(PoiInitial());

  final PoiRepository _repository;

  Future<void> getPoiList() async {
    emit(PoiLoading());
    try {
      final poiList = await _repository.getPois();
      if (poiList.list.isNotEmpty) {
        emit(PoiLoaded(poiList));
      } else {
        emit(const PoiError('Empty values'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(const PoiError('Failed to fetch POIs'));
    }
  }

  void deletePoiList() {
    try{
      _repository.deletePoiList();
      emit(PoiInitial());
    } catch (e) {
      debugPrint(e.toString());
      emit(const PoiError('Failed deleting POIs'));
    }

  }

}
