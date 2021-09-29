import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Bloc/My%20Location/mylocationmap_bloc.dart';
import 'package:restaurant/Widgets/Widgets.dart';


class MapLocationAddressPage extends StatefulWidget {
  @override
  _MapLocationAddressPageState createState() => _MapLocationAddressPageState();
}

class _MapLocationAddressPageState extends State<MapLocationAddressPage> {

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
              child: TextFrave(text: 'Locating...'),
            )
    );
  }
}


