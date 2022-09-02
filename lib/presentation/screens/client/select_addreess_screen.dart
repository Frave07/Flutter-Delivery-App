import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/addresses_response.dart';
import 'package:restaurant/domain/services/services.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';


class SelectAddressScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextCustom(text: 'Select Addresses',),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: IconButton(
          icon: Row(
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 21),
              TextCustom(text: 'Back', fontSize: 16, color: ColorsFrave.primaryColor )
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<ListAddress>>(
          future: userServices.getAddresses(),
          builder: (context, snapshot) 
            => (!snapshot.hasData)
              ? const ShimmerFrave()
              : _ListAddresses(listAddress: snapshot.data!)
        ),
    );
  }
}

class _ListAddresses extends StatelessWidget {
  
  final List<ListAddress> listAddress;

  const _ListAddresses({Key? key, required this.listAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return ( listAddress.length  != 0 ) 
    ? ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        itemCount: listAddress.length,
        itemBuilder: (_, i) 
          => Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: ListTile(
                leading: BlocBuilder<UserBloc, UserState>(
                  builder: (_, state) 
                    => ( state.uidAddress == listAddress[i].id ) ? Icon(Icons.radio_button_checked_rounded, color: ColorsFrave.primaryColor) : Icon(Icons.radio_button_off_rounded)
                ),
                title: TextCustom(text: listAddress[i].street, fontSize: 20, fontWeight: FontWeight.w500 ),
                subtitle: TextCustom(text: listAddress[i].reference, fontSize: 16, color: ColorsFrave.secundaryColor),
                onTap: () => userBloc.add(OnSelectAddressButtonEvent( listAddress[i].id, listAddress[i].reference)),
              ),
            ),
        )
    : _WithoutListAddress();
  }
}

class _WithoutListAddress extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('Assets/my-location.svg', height: 400 ),
          const TextCustom(text: 'Without Address', fontSize: 25, fontWeight: FontWeight.w500, color: ColorsFrave.secundaryColor ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}