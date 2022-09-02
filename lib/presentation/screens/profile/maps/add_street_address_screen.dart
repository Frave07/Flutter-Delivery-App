import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/helpers/navigator_route_fade_in.dart';
import 'package:restaurant/presentation/screens/profile/list_addresses_screen.dart';
import 'package:restaurant/presentation/screens/profile/maps/map_address_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class AddStreetAddressScreen extends StatefulWidget {

  @override
  _AddStreetAddressScreenState createState() => _AddStreetAddressScreenState();
}


class _AddStreetAddressScreenState extends State<AddStreetAddressScreen> {

  late TextEditingController _streetAddressController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() { 
    _streetAddressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() { 
    _streetAddressController.clear();
    _streetAddressController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context){

    final userBloc = BlocProvider.of<UserBloc>(context);
    final myLocationBloc = BlocProvider.of<MylocationmapBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        
        if( state is LoadingUserState ){

          modalLoading(context);

        } else if ( state is SuccessUserState ){

          Navigator.pop(context);
          modalSuccess(context, 'Street Address added successfully', () => Navigator.pushReplacement(context, routeFrave(page: ListAddressesScreen())));

        } else if ( state is FailureUserState ){

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextCustom(text: state.error, color: Colors.white), backgroundColor: Colors.red));

        }

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'New Address', fontSize: 19),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 80,
            leading: TextButton(
              onPressed: () => Navigator.pushReplacement(context, routeFrave(page: ListAddressesScreen())), 
              child: const TextCustom(text: 'Cancel', color: ColorsFrave.primaryColor, fontSize: 17 )
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if( _keyForm.currentState!.validate() ){
                    userBloc.add( 
                      OnAddNewAddressEvent( 
                        _streetAddressController.text.trim(), 
                        myLocationBloc.state.addressName,
                        myLocationBloc.state.locationCentral!
                      )
                    );
                  }
                }, 
                child: const TextCustom(text: 'Save', color: ColorsFrave.primaryColor, fontSize: 17 )
              ),
            ],
        ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextCustom(text: 'Street Address'),
                  const SizedBox(height: 5.0),
                  FormFieldFrave(
                    controller: _streetAddressController,
                    validator: RequiredValidator(errorText: 'Street Address is required'),
                  ),
                  const SizedBox(height: 20.0),
                  const TextCustom(text: 'Reference'),
                  const SizedBox(height: 5.0),
                  InkWell(
                    onTap: () async {
                      
                      final permissionGPS = await Permission.location.isGranted;
                      final gpsActive = await Geolocator.isLocationServiceEnabled();
          
                      if( permissionGPS && gpsActive ){
                        Navigator.push(context, navigatorPageFadeInFrave(context, MapLocationAddressScreen()));
                      }else {
                        Navigator.pop(context);
                      }
          
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: .5),
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: BlocBuilder<MylocationmapBloc, MylocationmapState>(
                        builder: (_, state) 
                          => TextCustom(text: state.addressName)
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: const TextCustom(text: 'Press to select direction', fontSize: 16, color: Colors.grey )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}