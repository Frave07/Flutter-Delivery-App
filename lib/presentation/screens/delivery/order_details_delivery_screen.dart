import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/order_details_response.dart';
import 'package:restaurant/domain/models/response/orders_by_status_response.dart';
import 'package:restaurant/domain/services/services.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/date_custom.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/delivery/map_delivery_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';


class OrdersDetailsDeliveryScreen extends StatefulWidget {

  final OrdersResponse order;

  const OrdersDetailsDeliveryScreen({ required this.order });

  @override
  _OrdersDetailsDeliveryScreenState createState() => _OrdersDetailsDeliveryScreenState();
}


class _OrdersDetailsDeliveryScreenState extends State<OrdersDetailsDeliveryScreen> {

  late MylocationmapBloc mylocationmapBloc;

  @override
  void initState() {
    mylocationmapBloc = BlocProvider.of<MylocationmapBloc>(context);
    mylocationmapBloc.initialLocation();
    super.initState();
  }

  @override
  void dispose() {
    mylocationmapBloc.cancelLocation();
    super.dispose();
  }


  void accessGps( PermissionStatus status, BuildContext context ){

    switch (status){
      case PermissionStatus.granted:
        Navigator.pushReplacement(context, routeFrave(page: MapDeliveryScreen(order: widget.order)));
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

    final orderBloc = BlocProvider.of<OrdersBloc>(context);

    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        
        if( state is LoadingOrderState ){

          modalLoading(context);

        }else if( state is SuccessOrdersState ){

          Navigator.pop(context);
          modalSuccess(context, 'ON WAY', () async => accessGps( await Permission.location.request(), context)); 

        
        }else if ( state is FailureOrdersState ){

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextCustom(text: state.error, color: Colors.white), backgroundColor: Colors.red));

        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: TextCustom(text: 'ORDER N# ${widget.order.orderId}', fontWeight: FontWeight.w500 ),
            centerTitle: true,
            leadingWidth: 80,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_back_ios_new_rounded, size: 17, color: ColorsFrave.primaryColor ),
                  TextCustom(text: 'Back', color: ColorsFrave.primaryColor, fontSize: 17)
                ],
              ),
            ),
          ),
        body: Column(
            children: [
              Expanded(
                flex: 2,
                child: FutureBuilder<List<DetailsOrder>>(
                  future: ordersServices.gerOrderDetailsById( widget.order.orderId.toString() ),
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
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(text: 'TOTAL', color: ColorsFrave.primaryColor, fontSize: 18, fontWeight: FontWeight.w500),
                        TextCustom(text: '\$ ${widget.order.amount}0', fontSize: 22, fontWeight: FontWeight.w500),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(text: 'PAYMENT', color: ColorsFrave.primaryColor, fontSize: 17, fontWeight: FontWeight.w500),
                        TextCustom(text: widget.order.payType, fontSize: 16),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'CLIENT', color: ColorsFrave.primaryColor, fontSize: 17, fontWeight: FontWeight.w500),
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage( (widget.order.clientImage != '') ? '${Environment.endpointBase}${widget.order.clientImage}' : '${Environment.endpointBase}without-image.png')
                                )
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            TextCustom(text: '${widget.order.cliente}'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'DATE', color: ColorsFrave.primaryColor, fontSize: 17, fontWeight: FontWeight.w500),
                        TextCustom(text: DateCustom.getDateOrder(widget.order.currentDate.toString()), fontSize: 16),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'ADDRESS', color: ColorsFrave.primaryColor, fontSize: 17, fontWeight: FontWeight.w500),
                        TextCustom(text: widget.order.reference, maxLine: 1, fontSize: 15),
                      ],
                    ),
                    const SizedBox(height: 15.0)
                  ],
                ),
              ),
              ( widget.order.status != 'DELIVERED')
              ? Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<MylocationmapBloc, MylocationmapState>(
                        builder: (context, state) 
                          =>  BtnFrave(
                          text:  widget.order.status == 'DISPATCHED' ? 'START DELIVERY' : 'GO TO MAP',
                          color: widget.order.status == 'DISPATCHED' ? Color(0xff0C6CF2) : Colors.indigo,
                          fontWeight: FontWeight.w500,
                          onPressed: (){
                            if( widget.order.status == 'DISPATCHED' ){
                              if( state.location != null ){
                                orderBloc.add( OnUpdateStatusOrderOnWayEvent(widget.order.orderId.toString(), state.location! ));
                              }
                            }
                            if( widget.order.status == 'ON WAY' ){
                              Navigator.push(context, routeFrave(page: MapDeliveryScreen(order: widget.order)));
                            }
                          },
                        ),
                      ) 
                    ],
                  ),
                )
              : const SizedBox()
            ],
          ),
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
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: listProductDetails.length,
      separatorBuilder: (_, index) => Divider(),
      itemBuilder: (_, i) 
        => Container(
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

