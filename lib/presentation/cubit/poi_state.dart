part of 'poi_cubit.dart';

abstract class PoiState extends Equatable {
  const PoiState();
  @override
  List<Object> get props => [];
}

class PoiInitial extends PoiState {}
class PoiLoading extends PoiState {}
class PoiLoaded extends PoiState {
  final PoiList poiList;

  const PoiLoaded(this.poiList);
  @override
  List<Object> get props => [poiList];
}
class PoiError extends PoiState {
  final String message;

  const PoiError(this.message);
  @override
  List<Object> get props => [message];
}


