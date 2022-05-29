import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant/Controller/OrdersController.dart';
import 'package:restaurant/Helpers/Date.dart';
import 'package:restaurant/Models/Response/OrderDetailsResponse.dart';
import 'package:restaurant/Models/Response/OrdersClientResponse.dart';
import 'package:restaurant/Screen/Client/ClientMapPage.dart';
import 'package:restaurant/Services/url.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';


class ClientDetailsOrderPage extends StatelessWidget {

  final OrdersClient orderClient;

  const ClientDetailsOrderPage({ required this.orderClient});


  void accessGps( PermissionStatus status, BuildContext context ){

    switch (status){
      case PermissionStatus.granted:
        Navigator.pushReplacement(context, routeFrave(page: ClientMapPage(orderClient: orderClient)));
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
        title: TextFrave(text: 'ORDER # ${orderClient.id}', fontSize: 17, fontWeight: FontWeight.w500 ),
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
              TextFrave(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor )
            ],
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10.0),
            child: TextFrave(
              text: orderClient.status!, 
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
            child: FutureBuilder<List<DetailsOrder>?>(
              future: ordersController.gerOrderDetailsById( orderClient.id.toString() ),
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
                    const TextFrave(text: 'TOTAL', fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor ),
                    TextFrave(text: '\$ ${orderClient.amount}0', fontWeight: FontWeight.w500),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextFrave(text: 'DELIVERY', fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor, fontSize: 17),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage( (orderClient.imageDelivery != null ) ? URLS.BASE_URL + orderClient.imageDelivery! : URLS.BASE_URL + 'without-image.png' )
                            )
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        TextFrave(text: (orderClient.deliveryId != 0 ) ? orderClient.delivery! : 'Not assigned', fontSize: 17),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextFrave(text: 'DATE', fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor , fontSize: 17),
                    TextFrave(text: DateFrave.getDateOrder(orderClient.currentDate.toString()), fontSize: 16),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextFrave(text: 'ADDRESS', fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor , fontSize: 16),
                    TextFrave(text: orderClient.reference!, fontSize: 16, maxLine: 1),
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
                    image: NetworkImage( URLS.BASE_URL  + listProductDetails[i].picture! )
                  )
                ),
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFrave(text: listProductDetails[i].nameProduct!, fontWeight: FontWeight.w500 ),
                  const SizedBox(height: 5.0),
                  TextFrave(text: 'Quantity: ${listProductDetails[i].quantity}', color: Colors.grey, fontSize: 17),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextFrave(text: '\$ ${listProductDetails[i].total}'),
                )
              )
            ],
          ),
        ),
    );
  }
}
