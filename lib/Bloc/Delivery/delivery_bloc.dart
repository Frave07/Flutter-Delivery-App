import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {

  DeliveryBloc() : super(DeliveryState()){

    on<OnSelectDeliveryEvent>( _onSelectDelivery );
    on<OnUnSelectDeliveryEvent>(_onUnSelectDelivery);

  }

  Future<void> _onSelectDelivery( OnSelectDeliveryEvent event, Emitter<DeliveryState> emit ) async {

    emit( state.copyWith( idDelivery: event.idDelivery, notificationTokenDelivery: event.notificationToken ) );

  }


  Future<void> _onUnSelectDelivery( OnUnSelectDeliveryEvent event, Emitter<DeliveryState> emit ) async {

    emit( state.copyWith( idDelivery: '0', notificationTokenDelivery: '') );

  }




}
