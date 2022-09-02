import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/orders_by_status_response.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/delivery/delivery_home_screen.dart';
import 'package:restaurant/presentation/screens/delivery/order_delivered_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class MapDeliveryScreen extends StatefulWidget {

  final OrdersResponse order;

  const MapDeliveryScreen({required this.order});
  
  @override
  _MapDeliveryScreenState createState() => _MapDeliveryScreenState();
}

class _MapDeliveryScreenState extends State<MapDeliveryScreen> with WidgetsBindingObserver {
  
  late MylocationmapBloc mylocationmapBloc;
  late MapdeliveryBloc mapDeliveryBloc;
  
  @override
  void initState() {
    mylocationmapBloc = BlocProvider.of<MylocationmapBloc>(context);
    mapDeliveryBloc = BlocProvider.of<MapdeliveryBloc>(context);
    mylocationmapBloc.initialLocation();
    mapDeliveryBloc.initSocketDelivery();
    WidgetsBinding.instance.addObserver(this);
   
    super.initState();
  }

  @override
  void dispose() {
    mylocationmapBloc.cancelLocation();
    mapDeliveryBloc.disconectSocket();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    
    if( state == AppLifecycleState.resumed ){

      if( !await Geolocator.isLocationServiceEnabled() || !await Permission.location.isGranted ){

        Navigator.pushReplacement(context, routeFrave(page: DeliveryHomeScreen()));

      }
    }
  }


  @override
  Widget build(BuildContext context){

    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        
        if( state is LoadingOrderState ){

          modalLoading(context);

        } else if ( state is SuccessOrdersState ){

          Navigator.pop(context);
          modalSuccess(context, 'DELIVERED', () => Navigator.pushAndRemoveUntil(context, routeFrave(page: OrderDeliveredScreen()), (route) => false));

        } else if ( state is FailureOrdersState ){

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextCustom(text: state.error, color: Colors.white), backgroundColor: Colors.red));

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
                const SizedBox(height: 10.0),
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
              const Icon(Icons.location_on_outlined, size: 28, color: Colors.black87),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextCustom(text: 'Delivery Address', fontSize: 15, color: Colors.grey),
                  TextCustom(text: order.reference, fontSize: 16, maxLine: 2),
                ],
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage('${Environment.endpointBase}${order.clientImage}')
                  )
                ), 
              ),
              const SizedBox(width: 10.0),
              TextCustom(text: order.cliente),
              const Spacer(),
              InkWell(
                onTap: () async => await urlLauncherFrave.makePhoneCall('tel:${order.clientPhone}'),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200]
                  ),
                  child: const Icon(Icons.phone, color: ColorsFrave.primaryColor),
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
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
                  double.parse(order.latitude), 
                  double.parse(order.longitude)
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
          mapDelivery.add( OnMarkertsDeliveryEvent( state.location!, LatLng(double.parse(order.latitude), double.parse(order.longitude))) );
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
              child: const TextCustom(text: 'Locating...'),
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
        margin: const EdgeInsets.only(right: 10.0),
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
            onTap: () async => await urlLauncherFrave.openMapLaunch(order.latitude, order.longitude),
            child: Image.asset('Assets/google-map.png', height: 30)
          )
        ),
      );
  }



} 


