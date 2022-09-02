import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'general_event.dart';
part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {
  GeneralBloc() : super(GeneralInitial()){

    on<OnSelectedNavigationBottom>( _onSelectedNavigationBottom );
    on<OnShowOrHidePasswordEvent>( _onShowOrHidePassword );
    on<OnShowOrHideNewPasswordEvent>( _onShowOrHideNewPassword );
    on<OnShowOrHideRepeatPasswordEvent>( _onShowOrHideRepetPassword );
  }

  Future<void> _onSelectedNavigationBottom( OnSelectedNavigationBottom event, Emitter<GeneralState> emit ) async {

    emit( state.copyWith( selectedIndex: event.selectIndex ) );

  }

  Future<void> _onShowOrHidePassword( OnShowOrHidePasswordEvent event, Emitter<GeneralState> emit ) async {

    emit( state.copyWith(isShowPassword: event.isShow) );

  }

  Future<void> _onShowOrHideNewPassword( OnShowOrHideNewPasswordEvent event, Emitter<GeneralState> emit ) async {

    emit( state.copyWith( isNewPassword: event.isNewPassword ) );

  }

  Future<void> _onShowOrHideRepetPassword( OnShowOrHideRepeatPasswordEvent event, Emitter<GeneralState> emit ) async {

    emit( state.copyWith( isRepeatpassword: event.isRepeatPassword ) );

  }

}
