import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/models/response/order_details_response.dart';
import 'package:restaurant/domain/models/response/orders_client_response.dart';
import 'package:restaurant/domain/services/orders_services.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/date_custom.dart';
import 'package:restaurant/presentation/screens/client/client_map_scrren.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';


class ClientDetailsOrderScreen extends StatelessWidget {

  final OrdersClient orderClient;

  const ClientDetailsOrderScreen({ required this.orderClient});


  void accessGps( PermissionStatus status, BuildContext context ){

    switch (status){
      case PermissionStatus.granted:
        Navigator.pushReplacement(context, routeFrave(page: ClientMapScreen(orderClient: orderClient)));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextCustom(text: 'ORDER # ${orderClient.id}', fontSize: 17, fontWeight: FontWeight.w500 ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 17),
              TextCustom(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor )
            ],
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10.0),
            child: TextCustom(
              text: orderClient.status, 
              fontSize: 16, 
              fontWeight: FontWeight.w500,
              color: (orderClient.status == 'DELIVERED' ? ColorsFrave.primaryColor : ColorsFrave.secundaryColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FutureBuilder<List<DetailsOrder>>(
              future: ordersServices.gerOrderDetailsById('${orderClient.id}'),
              builder: (context, snapshot) 
                => ( !snapshot.hasData )
                    ? Column(
                      children: const [
                        ShimmerFrave(),
                        SizedBox(height: 10.0),
                        ShimmerFrave(),
                        SizedBox(height: 10.0),
                        ShimmerFrave(),
                      ],
                    )
                  : _ListProductsDetails(listProductDetails: snapshot.data!)
              
            )
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(text: 'TOTAL', fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor ),
                    TextCustom(text: '\$ ${orderClient.amount}0', fontWeight: FontWeight.w500),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(text: 'DELIVERY', fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor, fontSize: 17),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage( (orderClient.imageDelivery != '' ) ? '${Environment.endpointBase}${orderClient.imageDelivery}' : '${Environment.endpointBase}without-image.png' )
                            )
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        TextCustom(text: (orderClient.deliveryId != 0 ) ? orderClient.delivery : 'Not assigned', fontSize: 17),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(text: 'DATE', fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor , fontSize: 17),
                    TextCustom(text: DateCustom.getDateOrder(orderClient.currentDate.toString()), fontSize: 16),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(text: 'ADDRESS', fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor , fontSize: 16),
                    TextCustom(text: orderClient.reference, fontSize: 16, maxLine: 1),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          (orderClient.status == 'ON WAY')
          ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: BtnFrave(
              text: 'FOLLOW DELIVERY',
              fontWeight: FontWeight.w500,
              onPressed: () async => accessGps(await Permission.location.request(), context),
            ),
          )
          : const SizedBox()
        ],
      ),
    );
  }
}

class _ListProductsDetails extends StatelessWidget {
  
  final List<DetailsOrder> listProductDetails;

  const _ListProductsDetails({required this.listProductDetails});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: listProductDetails.length,
      separatorBuilder: (_, index) => Divider(),
      itemBuilder: (_, i) 
        => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${Environment.endpointBase}${listProductDetails[i].picture}')
                  )
                ),
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(text: listProductDetails[i].nameProduct, fontWeight: FontWeight.w500 ),
                  const SizedBox(height: 5.0),
                  TextCustom(text: 'Quantity: ${listProductDetails[i].quantity}', color: Colors.grey, fontSize: 17),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextCustom(text: '\$ ${listProductDetails[i].total}'),
                )
              )
            ],
          ),
        ),
    );
  }
}
