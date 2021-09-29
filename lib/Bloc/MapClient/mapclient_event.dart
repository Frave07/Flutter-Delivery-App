part of 'mapclient_bloc.dart';

@immutable
abstract class MapclientEvent {}

class OnReadyMapClientEvent extends MapclientEvent {}

class OnMarkerClientEvent extends MapclientEvent {

  final LatLng delivery;
  final LatLng client;

  OnMarkerClientEvent(this.delivery, this.client);
}

class OnPositionDeliveryEvent extends MapclientEvent {
  final LatLng location;

  OnPositionDeliveryEvent(this.location);
}