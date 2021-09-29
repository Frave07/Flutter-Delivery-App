import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant/Bloc/MapClient/mapclient_bloc.dart';
import 'package:restaurant/Helpers/Helpers.dart';
import 'package:restaurant/Models/Response/OrdersClientResponse.dart';
import 'package:restaurant/Services/url.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/Widgets.dart';

class ClientMapPage extends StatefulWidget {

  final OrdersClient orderClient;

  const ClientMapPage({required this.orderClient});

  @override
  _ClientMapPageState createState() => _ClientMapPageState();
}

class _ClientMapPageState extends State<ClientMapPage> {

  late MapclientBloc mapClientBloc;

  @override
  void initState() {

    mapClientBloc = BlocProvider.of<MapclientBloc>(context);
    mapClientBloc.add( OnMarkerClientEvent(
        LatLng(double.parse(widget.orderClient.latitude!), double.parse(widget.orderClient.longitude!)), 
        LatLng(double.parse(widget.orderClient.latClient!), double.parse(widget.orderClient.lngClient!))
      ) 
    );
    mapClientBloc.initSocketDelivery(widget.orderClient.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    mapClientBloc.disconectSocket();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        children: [
          _MapClient(orderClient: widget.orderClient),

          Positioned(
            left: 10,
            right: 10,
            bottom: 20,
            child: _InfoCardClient( widget.orderClient)
          )
        ],
      ),
    );
  }
}

class _MapClient extends StatelessWidget {

  final OrdersClient orderClient;

  const _MapClient({required this.orderClient});
  
  @override
  Widget build(BuildContext context) {

    final mapClientBloc = BlocProvider.of<MapclientBloc>(context);
    
    return BlocBuilder<MapclientBloc, MapclientState>(
      builder: (context, state) 
        => GoogleMap(
        initialCameraPosition: CameraPosition(target:  LatLng(double.parse(orderClient.latitude!), double.parse(orderClient.longitude!)), zoom: 17.5),
        zoomControlsEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: mapClientBloc.initMapClient,
        markers: state.markerClient.values.toSet(),
      ),
    );
      
  }
}


class _InfoCardClient extends StatelessWidget {
  
  final OrdersClient orderClient;

  const _InfoCardClient(this.orderClient);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 7, spreadRadius: 5)
        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage( URLS.BASE_URL + orderClient.imageDelivery! )
                  )
                ), 
              ),
              SizedBox(width: 10.0),
              TextFrave(text: orderClient.delivery!),
              Spacer(),
              InkWell(
                onTap: () async => await urlLauncherFrave.makePhoneCall('tel:${orderClient.deliveryPhone}'),
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
        ],
      ),
    );
  }
}