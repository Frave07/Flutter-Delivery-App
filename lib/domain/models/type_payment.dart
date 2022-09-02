import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TypePaymentMethod {

  final int uid;
  final String typePayment;
  final IconData icon;
  final Color color;

  TypePaymentMethod(this.uid, this.typePayment, this.icon, this.color);


  static List<TypePaymentMethod> listTypePayment = [

    TypePaymentMethod(1, 'CREDIT CARD', FontAwesomeIcons.creditCard, Color(0xff002C8B) ),
    TypePaymentMethod(2, 'MERCADO PAGO', FontAwesomeIcons.handshake, Colors.lightBlue),
    TypePaymentMethod(3, 'GOOGLE PAY', FontAwesomeIcons.google, Colors.black ),
    TypePaymentMethod(4, 'PAYPAL', FontAwesomeIcons.paypal, Color(0xff002C8B) ),
    TypePaymentMethod(5, 'CASH PAYMENT', FontAwesomeIcons.moneyBill, Colors.green[800]!),

  ];

}

