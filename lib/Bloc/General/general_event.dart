part of 'general_bloc.dart';

@immutable
abstract class GeneralEvent {}


class OnSelectedNavigationBottom extends GeneralEvent {
  final int selectIndex;

  OnSelectedNavigationBottom(this.selectIndex);
}

class OnShowOrHidePasswordEvent extends GeneralEvent {
  final bool isShow;

  OnShowOrHidePasswordEvent(this.isShow);
}


class OnShowOrHideNewPasswordEvent extends GeneralEvent{
  final bool isNewPassword;

  OnShowOrHideNewPasswordEvent(this.isNewPassword);
}


class OnShowOrHideRepeatPasswordEvent extends GeneralEvent{
  final bool isRepeatPassword;

  OnShowOrHideRepeatPasswordEvent(this.isRepeatPassword);
}




