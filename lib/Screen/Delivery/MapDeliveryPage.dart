import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant/Bloc/MapDelivery/mapdelivery_bloc.dart';
import 'package:restaurant/Bloc/My%20Location/mylocationmap_bloc.dart';
import 'package:restaurant/Bloc/Orders/orders_bloc.dart';
import 'package:restaurant/Helpers/Helpers.dart';
import 'package:restaurant/Models/Response/OrdersByStatusResponse.dart';
import 'package:restaurant/Screen/Delivery/DeliveryHomePage.dart';
import 'package:restaurant/Screen/Delivery/OrderDeliveredPage.dart';
import 'package:restaurant/Services/url.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';

class MapDeliveryPage extends StatefulWidget {

  final OrdersResponse order;

  const MapDeliveryPage({required this.order});
  
  @override
  _MapDeliveryPageState createState() => _MapDeliveryPageState();
}

class _MapDeliveryPageState extends State<MapDeliveryPage> with WidgetsBindingObserver {
  
  late MylocationmapBloc mylocationmapBloc;
  late MapdeliveryBloc mapDeliveryBloc;
  
  @override
  void initState() {
    mylocationmapBloc = BlocProvider.of<MylocationmapBloc>(context);
    mapDeliveryBloc = BlocProvider.of<MapdeliveryBloc>(context);
    mylocationmapBloc.initialLocation();
    mapDeliveryBloc.initSocketDelivery();
    WidgetsBinding.instance!.addObserver(this);
   
    super.initState();
  }

  @override
  void dispose() {
    mylocationmapBloc.cancelLocation();
    mapDeliveryBloc.disconectSocket();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    
    if( state == AppLifecycleState.resumed ){

      if( !await Geolocator.isLocationServiceEnabled() || !await Permission.location.isGranted ){

        Navigator.pushReplacement(context, routeFrave(page: DeliveryHomePage()));

      }
    }
  }


  @override
  Widget build(BuildContext context)
  {
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        
        if( state is LoadingOrderState ){

          modalLoading(context);

        } else if ( state is SuccessOrdersState ){

          Navigator.pop(context);
          modalSuccess(context, 'DELIVERED', () => Navigator.pushAndRemoveUntil(context, routeFrave(page: OrderDeliveredPage()), (route) => false));

        } else if ( state is FailureOrdersState ){

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextFrave(text: state.error, color: Colors.white), backgroundColor: Colors.red));

        }

      },
      child: Scaffold(
        body: Stack(
          children: [
            _MapDelivery(order: widget.order),
    
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: _BtnLocation()
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: _BtnGoogleMap(order: widget.order)
                ),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: _InformationBottom(order: widget.order),
            )
          ],
        ),
      ),
    );
  }
}

class _InformationBottom extends StatelessWidget {

  final OrdersResponse order;

  const _InformationBottom({required this.order});

  @override
  Widget build(BuildContext context) {
    
    final orderBloc = BlocProvider.of<OrdersBloc>(context);

    return Container(
      padding: EdgeInsets.all(15.0),
      height: 183,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 7, spreadRadius: 5)
        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 28, color: Colors.black87),
              SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFrave(text: 'Delivery Address', fontSize: 15, color: Colors.grey),
                  TextFrave(text: order.reference!, fontSize: 16, maxLine: 2),
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage( URLS.BASE_URL + order.clientImage! )
                  )
                ), 
              ),
              SizedBox(width: 10.0),
              TextFrave(text: order.cliente!),
              Spacer(),
              InkWell(
                onTap: () async => await urlLauncherFrave.makePhoneCall('tel:${order.clientPhone}'),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200]
                  ),
                  child: Icon(Icons.phone, color: ColorsFrave.primaryColor),
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          BlocBuilder<MylocationmapBloc, MylocationmapState>(
            builder: (context, state) 
              => BtnFrave(
              height: 45,
              text: 'DELIVERED',
              fontWeight: FontWeight.w500,
              onPressed: (){
          
                final distanceDelivery = Geolocator.distanceBetween(
                  state.location!.latitude, 
                  state.location!.longitude, 
                  double.parse(order.latitude!), 
                  double.parse(order.longitude!)
                );
          
                if( distanceDelivery <= 150 ){
          
                  orderBloc.add( OnUpdateStatusOrderDeliveredEvent(order.orderId.toString()) );
          
                } else {
          
                  modalInfoFrave(context, 'Its still far away');
          
                }
              },
            ),
          )
        ],
      ),
    );
  }
}


class _MapDelivery extends StatelessWidget {

  final OrdersResponse order;

  const _MapDelivery({required this.order});
  
  @override
  Widget build(BuildContext context) {
  
    final mapDelivery = BlocProvider.of<MapdeliveryBloc>(context);
    final myLocationDeliveryBloc = BlocProvider.of<MylocationmapBloc>(context);
    
    return BlocBuilder<MylocationmapBloc, MylocationmapState>(
      builder: (_, state){

        if( state.location != null ){
          mapDelivery.add( OnMarkertsDeliveryEvent( state.location!, LatLng(double.parse(order.latitude!), double.parse(order.longitude!))) );
          mapDelivery.add( OnEmitLocationDeliveryEvent(order.orderId.toString(), myLocationDeliveryBloc.state.location!) );
        } 

        return  ( state.existsLocation ) 
          ? GoogleMap(
              initialCameraPosition: CameraPosition(target: state.location!, zoom: 17.5),
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: mapDelivery.initMapDeliveryFrave,
              markers: mapDelivery.state.markers.values.toSet(),
              polylines: mapDelivery.state.polyline!.values.toSet(),
            )
          : Center(
              child: TextFrave(text: 'Locating...'),
            );
      } 
    );
  }
}


class _BtnLocation extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final mapDeliveryBloc = BlocProvider.of<MapdeliveryBloc>(context);
    final locationBloc = BlocProvider.of<MylocationmapBloc>(context);

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: -5)
          ]
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
            icon: Icon(Icons.my_location_rounded, color: ColorsFrave.primaryColor ),
            onPressed: () => mapDeliveryBloc.moveCamareLocation(locationBloc.state.location!),
          ),
        ),
      ),
    );
  }
}


class _BtnGoogleMap extends StatelessWidget {
  
  final OrdersResponse order;

  const _BtnGoogleMap({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: -5)
          ]
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: InkWell(
            onTap: () async => await urlLauncherFrave.openMapLaunch(order.latitude!, order.longitude!),
            child: Image.asset('Assets/google-map.png', height: 30)
          )
        ),
      );
  }



} 


