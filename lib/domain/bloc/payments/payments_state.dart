part of 'payments_bloc.dart';

@immutable
class PaymentsState {

  final String typePaymentMethod;
  final IconData iconPayment;
  final Color colorPayment;

  PaymentsState({
    this.typePaymentMethod = 'CREDIT CARD',
    this.iconPayment = FontAwesomeIcons.creditCard,
    this.colorPayment = const Color(0xff002C8B)
  });


  PaymentsState copyWith({ String? typePaymentMethod, IconData? iconPayment,  Color? colorPayment })
    => PaymentsState(
      typePaymentMethod: typePaymentMethod ?? this.typePaymentMethod,
      iconPayment: iconPayment ?? this.iconPayment,
      colorPayment: colorPayment ?? this.colorPayment 
    );

}
