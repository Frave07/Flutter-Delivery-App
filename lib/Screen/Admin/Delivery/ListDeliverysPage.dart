import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/Bloc/User/user_bloc.dart';
import 'package:restaurant/Controller/DeliveryController.dart';
import 'package:restaurant/Helpers/Helpers.dart';
import 'package:restaurant/Models/Response/GetAllDeliveryResponse.dart';
import 'package:restaurant/Screen/Admin/Delivery/AddNewDeliveryPage.dart';
import 'package:restaurant/Services/url.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';


class ListDeliverysPage extends StatefulWidget {
  @override
  State<ListDeliverysPage> createState() => _ListDeliverysPageState();
}

class _ListDeliverysPageState extends State<ListDeliverysPage> {

  
  @override
  Widget build(BuildContext context) {

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {

        if( state is LoadingUserState ) modalLoading(context);

        else if ( state is SuccessUserState ){

          Navigator.pop(context);
          modalSuccess(context, 'Delivery Deleted', () {
            Navigator.pop(context);
            setState(() {});
          });

        } else if ( state is FailureUserState ){

          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFrave(text: 'List Delivery men'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 17),
                TextFrave(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor,)
              ],
            ),
          ),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () => Navigator.push(context, routeFrave(page: AddNewDeliveryPage())), 
              child: TextFrave(text: 'Add', color: ColorsFrave.primaryColor, fontSize: 17)
            )
          ],
        ),
        body: FutureBuilder<List<Delivery>?>(
          future: deliveryController.getAlldelivery(),
          builder: (context, snapshot) 
            => ( !snapshot.hasData )
              ? Column(
                  children: [
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
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        itemCount: listDelivery.length,
        itemBuilder: (context, i) 
          => Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
              onTap: () => modalDelete(
                context, 
                listDelivery[i].nameDelivery!, 
                listDelivery[i].image!,
                (){
                  userBloc.add( OnUpdateDeliveryToClientEvent(listDelivery[i].personId.toString()) );
                  Navigator.pop(context);
                } 
              ),
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
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
                          image: NetworkImage( URLS.BASE_URL + listDelivery[i].image! )
                        )
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFrave(text: listDelivery[i].nameDelivery!, fontWeight: FontWeight.w500 ),
                        SizedBox(height: 5.0),
                        TextFrave(text: listDelivery[i].phone!, color: Colors.grey),
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
          SizedBox(height: 20.0),
          TextFrave(text: 'Without Delivery men', color: ColorsFrave.primaryColor, fontSize: 20)
        ],
      ),
    );
  }



}