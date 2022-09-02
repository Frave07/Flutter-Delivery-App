import 'package:flutter/material.dart';
import 'package:restaurant/domain/models/response/orders_by_status_response.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/date_custom.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class CardOrdersDelivery extends StatelessWidget {

  final OrdersResponse orderResponse;
  final VoidCallback? onPressed;

  const CardOrdersDelivery({required this.orderResponse, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
        ]
      ),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text: 'ORDER ID: ${orderResponse.orderId}'),
              const Divider(),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextCustom(text: 'Date', fontSize: 16, color: ColorsFrave.secundaryColor),
                  TextCustom(text: DateCustom.getDateOrder(orderResponse.currentDate.toString()), fontSize: 16),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextCustom(text: 'Client', fontSize:16, color: ColorsFrave.secundaryColor),
                  TextCustom(text: orderResponse.cliente, fontSize: 16),
                ],
              ),
              const SizedBox(height: 10.0),
              const TextCustom(text: 'Address shipping', fontSize: 16, color: ColorsFrave.secundaryColor),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextCustom(text: orderResponse.reference, fontSize: 16, maxLine: 2)
              ),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}