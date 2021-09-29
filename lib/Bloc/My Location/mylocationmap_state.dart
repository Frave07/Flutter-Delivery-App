part of 'mylocationmap_bloc.dart';

@immutable
class MylocationmapState {

  final bool existsLocation;
  final LatLng? location;
  final bool mapReady;
  final LatLng? locationCentral;
  final String addressName;

  MylocationmapState({
    this.existsLocation = false, 
    this.location,
    this.mapReady = false,
    this.locationCentral,
    this.addressName = ''
  });

  MylocationmapState copyWith({ bool? existsLocation, LatLng? location, bool? mapReady, LatLng? locationCentral, String? addressName })
    => MylocationmapState(
      existsLocation: existsLocation ?? this.existsLocation,
      location: location ?? this.location,
      mapReady: mapReady ?? this.mapReady,
      locationCentral: locationCentral ?? this.locationCentral,
      addressName: addressName ?? this.addressName
    );


}


class LoadingMyLocationState extends MylocationmapState {}

class SuccessMyLocationState extends MylocationmapState {}

class FailureMyLocationState extends MylocationmapState {
  final String error;

  FailureMyLocationState(this.error);
}
