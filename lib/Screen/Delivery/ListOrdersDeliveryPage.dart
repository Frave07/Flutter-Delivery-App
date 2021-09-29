import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/Controller/DeliveryController.dart';
import 'package:restaurant/Models/Response/OrdersByStatusResponse.dart';
import 'package:restaurant/Screen/Delivery/OrderDetailsDeliveryPage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';


class ListOrdersDeliveryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFrave(text: 'List of orders'),
        centerTitle: true,
        elevation: 0,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, size: 19, color: ColorsFrave.primaryColor ),
              TextFrave(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor )
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<OrdersResponse>?>(
        future: deliveryController.getOrdersForDelivery('DISPATCHED'),
        builder: (context, snapshot) 
          => ( !snapshot.hasData )
            ? Column(
                children: [
                  ShimmerFrave(),
                  SizedBox(height: 10.0),
                  ShimmerFrave(),
                  SizedBox(height: 10.0),
                  ShimmerFrave(),
                ],
              )
            : _ListOrdersForDelivery(listOrdersDelivery: snapshot.data!)
      ),
    );
  }
}

class _ListOrdersForDelivery extends StatelessWidget {
  
  final List<OrdersResponse> listOrdersDelivery;

  const _ListOrdersForDelivery({ required this.listOrdersDelivery});

  @override
  Widget build(BuildContext context) {
    return ( listOrdersDelivery.length != 0 ) 
      ? ListView.builder(
          itemCount: listOrdersDelivery.length,
          itemBuilder: (_, i) 
            => CardOrdersDelivery(
                orderResponse: listOrdersDelivery[i],
                onPressed: () => Navigator.push(context, routeFrave(page: OrdersDetailsDeliveryPage(order: listOrdersDelivery[i]))),
               )
        )
      : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset('Assets/no-data.svg', height: 300)),
          SizedBox(height: 15.0),
          TextFrave(text: 'Without Orders', color: ColorsFrave.primaryColor, fontWeight: FontWeight.w500, fontSize: 21)
        ],
      );
  }
}
