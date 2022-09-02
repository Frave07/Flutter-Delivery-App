import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/get_all_delivery_response.dart';
import 'package:restaurant/domain/services/services.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/admin/delivery/add_new_delivery_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class ListDeliverysScreen extends StatefulWidget {

  @override
  State<ListDeliverysScreen> createState() => _ListDeliverysScreenState();
}

class _ListDeliverysScreenState extends State<ListDeliverysScreen> {

  
  @override
  Widget build(BuildContext context) {

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if(state is LoadingUserState ){
          modalLoading(context);
        }
        if(state is SuccessUserState ){
          Navigator.pop(context);
          modalSuccess(context, 'Delivery Deleted', () {
            Navigator.pop(context);
            setState(() {});
          });

        }
        if(state is FailureUserState ){
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'List Delivery men'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 17),
                TextCustom(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor,)
              ],
            ),
          ),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () => Navigator.push(context, routeFrave(page: AddNewDeliveryScreen())), 
              child: const TextCustom(text: 'Add', color: ColorsFrave.primaryColor, fontSize: 17)
            )
          ],
        ),
        body: FutureBuilder<List<Delivery>?>(
          future: deliveryServices.getAlldelivery(),
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
              : _ListDelivery(listDelivery: snapshot.data! )
        ),
      ),
    );
  }
}

class _ListDelivery extends StatelessWidget {
  
  final List<Delivery> listDelivery;

  const _ListDelivery({required this.listDelivery});

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);
    
    return (listDelivery.length != 0)
    ? ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        itemCount: listDelivery.length,
        itemBuilder: (context, i) 
          => Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
              onTap: () => modalDelete(
                context, 
                listDelivery[i].nameDelivery, 
                listDelivery[i].image,
                (){
                  userBloc.add( OnUpdateDeliveryToClientEvent(listDelivery[i].personId.toString()) );
                  Navigator.pop(context);
                } 
              ),
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('${Environment.endpointBase}${listDelivery[i].image}')
                        )
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(text: listDelivery[i].nameDelivery, fontWeight: FontWeight.w500 ),
                        const SizedBox(height: 5.0),
                        TextCustom(text: listDelivery[i].phone, color: Colors.grey),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
      )
    : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('Assets/no-data.svg', height: 290),
          const SizedBox(height: 20.0),
          const TextCustom(text: 'Without Delivery men', color: ColorsFrave.primaryColor, fontSize: 20)
        ],
      ),
    );
  }



}