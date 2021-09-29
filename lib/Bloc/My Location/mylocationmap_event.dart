part of 'mylocationmap_bloc.dart';

@immutable
abstract class MylocationmapEvent {}

class OnChangeLocationEvent extends MylocationmapEvent {
  final LatLng location;

  OnChangeLocationEvent(this.location);
}


class OnMapReadyEvent extends MylocationmapEvent {}


class OnMoveMapEvent extends MylocationmapEvent {
  final LatLng location;

  OnMoveMapEvent(this.location);
}


class OnGetAddressLocationEvent extends MylocationmapEvent {
  final LatLng location;

  OnGetAddressLocationEvent(this.location);
}


