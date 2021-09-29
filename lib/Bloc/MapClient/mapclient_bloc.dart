import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/Helpers/Helpers.dart';
import 'package:restaurant/Services/url.dart';
import 'package:restaurant/Themes/ThemeMaps.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'mapclient_event.dart';
part 'mapclient_state.dart';

class MapclientBloc extends Bloc<MapclientEvent, MapclientState> {

  MapclientBloc() : super(MapclientState()){

    on<OnReadyMapClientEvent>( _onReadyMapClient );
    on<OnMarkerClientEvent>( _onMarkerClient );
    on<OnPositionDeliveryEvent>( _onPositionDelivery );
  }

  late GoogleMapController _mapController;
  late IO.Socket _socket;

  void initMapClient( GoogleMapController controller ){

    if( !state.isReadyMapClient ){

      this._mapController = controller;
      
      _mapController.setMapStyle( jsonEncode( themeMapsFrave ));

      add( OnReadyMapClientEvent() );

    }
  }


  void initSocketDelivery(String idOrder) {

    this._socket = IO.io( URLS.BASE_URL + 'orders-delivery-socket' , {
      'transports': ['websocket'], 
      'autoConnect': true,
    });

    this._socket.connect();

    this._socket.on('position/$idOrder', (data){

      add( OnPositionDeliveryEvent(LatLng(data['latitude'], data['longitude'])) );

    });

  }
  

  void disconectSocket(){

    this._socket.disconnect();

  }


  Future<void> _onReadyMapClient( OnReadyMapClientEvent event, Emitter<MapclientState> emit ) async {

    emit( state.copyWith( isReadyMapClient: true ) );

  }



  Future<void> _onMarkerClient( OnMarkerClientEvent event, Emitter<MapclientState> emit ) async {

    final marketCustom = await getAssetImageMarker('Assets/food-delivery-marker.png');
    final iconDestination = await getAssetImageMarker('Assets/delivery-destination.png');

    final markerDeliver = Marker(
      markerId: MarkerId('markerDeliver'),
      position: event.delivery,
      icon: marketCustom
    );

    final markerClient = Marker(
      markerId: MarkerId('markerClient'),
      position: event.client,
      icon: iconDestination
    );

    final newMarker = { ...state.markerClient };
    newMarker['markerDeliver'] = markerDeliver;
    newMarker['markerClient'] = markerClient;

    emit( state.copyWith( markerClient: newMarker ));

  }


  Future<void> _onPositionDelivery( OnPositionDeliveryEvent event, Emitter<MapclientState> emit ) async {

    final deliveryMarker = await getAssetImageMarker('Assets/food-delivery-marker.png');

    final markerDeliver = Marker(
      markerId: MarkerId('markerDeliver'),
      position: event.location,
      icon: deliveryMarker
    );

    final newMarker = { ...state.markerClient };
    newMarker['markerDeliver'] = markerDeliver;


    emit( state.copyWith( markerClient: newMarker ));

  }


}
