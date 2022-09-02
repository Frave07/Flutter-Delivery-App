part of 'general_bloc.dart';

@immutable
class GeneralState {

  final int selectedIndex;
  final bool isShowPassword;
  final bool isNewPassword;
  final bool isRepeatpassword;

  GeneralState({
    this.selectedIndex = 0,
    this.isShowPassword = true,
    this.isNewPassword = true,
    this.isRepeatpassword = true
  });

  GeneralState copyWith({ int? selectedIndex, bool? isShowPassword, bool? isNewPassword, bool? isRepeatpassword }) 
    => GeneralState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isNewPassword: isNewPassword ?? this.isNewPassword,
      isRepeatpassword: isRepeatpassword ?? this.isRepeatpassword
    );
}


class GeneralInitial extends GeneralState {}
