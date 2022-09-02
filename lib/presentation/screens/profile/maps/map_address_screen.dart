import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/components/manual_market_map.dart';

class MapLocationAddressScreen extends StatefulWidget {

  @override
  _MapLocationAddressScreenState createState() => _MapLocationAddressScreenState();
}

class _MapLocationAddressScreenState extends State<MapLocationAddressScreen> {

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


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        children: [
          _CreateMap(),

          ManualMarketMap()
        ],
      )
    );
  }
}

class _CreateMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mapLocation = BlocProvider.of<MylocationmapBloc>(context);

    return BlocBuilder<MylocationmapBloc, MylocationmapState>(
      builder: (context, state) 
        => ( state.existsLocation ) 
         ? GoogleMap(
            initialCameraPosition: CameraPosition(target: state.location!, zoom: 18),
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: mapLocation.initMapLocation,
            onCameraMove: (position) => mapLocation.add( OnMoveMapEvent( position.target ) ),
            onCameraIdle: (){
              if ( state.locationCentral != null ){
                mapLocation.add( OnGetAddressLocationEvent( mapLocation.state.locationCentral! ) );
              }
            },
           )
          : Center(
              child: const TextCustom(text: 'Locating...'),
            )
    );
  }
}


