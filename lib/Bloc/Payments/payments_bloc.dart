import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {

  PaymentsBloc() : super(PaymentsState()){

    on<OnSelectTypePaymentMethodEvent>( _onSelectTypePayment );
    on<OnClearTypePaymentMethodEvent>( _onClearTypePaymentMethod );

  }

  Future<void> _onSelectTypePayment( OnSelectTypePaymentMethodEvent event, Emitter<PaymentsState> emit ) async {

    emit( state.copyWith( typePaymentMethod: event.typePayment, iconPayment: event.icon, colorPayment: event.color ) );
    
  }

  Future<void> _onClearTypePaymentMethod( OnClearTypePaymentMethodEvent event, Emitter<PaymentsState> emit ) async {

    emit( state.copyWith( typePaymentMethod: 'CREDIT CARD' ) );

  }
  
}
