import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/Controller/OrdersController.dart';
import 'package:restaurant/Helpers/Date.dart';
import 'package:restaurant/Models/Response/OrdersClientResponse.dart';
import 'package:restaurant/Screen/Client/ClientDetailsOrderPage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';

class ClientOrdersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextFrave(text: 'My Orders', fontSize: 20 ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 17),
              TextFrave(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor )
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<OrdersClient>?>(
        future: ordersController.getListOrdersForClient(),
        builder: (context, snapshot) 
          => (!snapshot.hasData)
             ? Column(
               children: [
                 ShimmerFrave(),
                 SizedBox(height: 10.0),
                 ShimmerFrave(),
                 SizedBox(height: 10.0),
                 ShimmerFrave(),
               ],
             )
             : _ListOrdersClient(listOrders: snapshot.data!)
      ),
    );
  }
}


class _ListOrdersClient extends StatelessWidget {
  
  final List<OrdersClient> listOrders;

  const _ListOrdersClient({required this.listOrders});

  @override
  Widget build(BuildContext context) {
    return ( listOrders.length != 0 )
      ? ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          itemCount: listOrders.length,
          itemBuilder: (context, i) 
            => GestureDetector(
              onTap: () => Navigator.push(context, routeFrave(page: ClientDetailsOrderPage(orderClient: listOrders[i]))),
              child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  padding: EdgeInsets.all(15.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFrave(text: 'ORDER # ${listOrders[i].id}', fontSize: 16, fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor),
                          TextFrave(text: listOrders[i].status! ,
                            fontSize: 16, 
                            fontWeight: FontWeight.w500, 
                            color: ( listOrders[i].status == 'DELIVERED' ? ColorsFrave.primaryColor : ColorsFrave.secundaryColor )
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFrave(text: 'AMOUNT', fontSize: 15, fontWeight: FontWeight.w500),
                          TextFrave(text: '\$ ${listOrders[i].amount}0', fontSize: 16)
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFrave(text: 'DATE', fontSize: 15, fontWeight: FontWeight.w500),
                          TextFrave(text: DateFrave.getDateOrder(listOrders[i].currentDate.toString()), fontSize: 15)
                        ],
                      ),
                    ],
                  ),
                ),
            ),
        )
      : SvgPicture.asset('Assets/empty-cart.svg');
  }

}