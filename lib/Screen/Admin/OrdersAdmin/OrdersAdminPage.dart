import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/Controller/OrdersController.dart';
import 'package:restaurant/Helpers/Date.dart';
import 'package:restaurant/Helpers/FraveIndicator.dart';
import 'package:restaurant/Models/PayType.dart';
import 'package:restaurant/Models/Response/OrdersByStatusResponse.dart';
import 'package:restaurant/Screen/Admin/OrdersAdmin/OrderDetailsPage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';


class OrdersAdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    return DefaultTabController(
      length: payType.length, 
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFrave(text: 'List Orders', fontSize: 20),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_outlined, color: ColorsFrave.primaryColor, size: 17),
                TextFrave(text: 'Back', color: ColorsFrave.primaryColor, fontSize: 17)
              ],
            ),
          ),
          bottom: TabBar(
            indicatorWeight: 2,
            labelColor: ColorsFrave.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicator: FraveIndicatorTabBar(),
            isScrollable: true,
            tabs: List<Widget>.generate(payType.length, (i) 
              => Tab(
                  child: Text(payType[i], style: GoogleFonts.getFont('Roboto', fontSize: 17))
                )
            )
          ),
        ),
        body: TabBarView(
          children: payType.map((e) 
            => FutureBuilder<List<OrdersResponse>?>(
                future: ordersController.getOrdersByStatus( e ),
                builder: (context, snapshot) 
                  => ( !snapshot.hasData )
                      ? Column(
                          children: [
                            ShimmerFrave(),
                            SizedBox(height: 10),
                            ShimmerFrave(),
                            SizedBox(height: 10),
                            ShimmerFrave(),
                          ],
                        )
                      :  _ListOrders(listOrders: snapshot.data!)
            )
          ).toList(),
        ),
      )
    );
  }   
}


class _ListOrders extends StatelessWidget {
  
  final List<OrdersResponse> listOrders;

  const _ListOrders({required this.listOrders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOrders.length,
      itemBuilder: (context, i) 
        => _CardOrders(orderResponse: listOrders[i]),
    );
  }
}


class _CardOrders extends StatelessWidget {

  final OrdersResponse orderResponse;

  const _CardOrders({required this.orderResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: Colors.blueGrey, blurRadius: 8, spreadRadius: -5)
        ]
      ),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () => Navigator.push(context, routeFrave(page: OrderDetailsPage(order: orderResponse))),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFrave(text: 'ORDER ID: ${orderResponse.orderId}'),
              Divider(),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(text: 'Date', fontSize: 16, color: ColorsFrave.secundaryColor),
                  TextFrave(text: DateFrave.getDateOrder(orderResponse.currentDate.toString()), fontSize: 16),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(text: 'Client', fontSize:16, color: ColorsFrave.secundaryColor),
                  TextFrave(text: orderResponse.cliente!, fontSize: 16),
                ],
              ),
              SizedBox(height: 10.0),
              TextFrave(text: 'Address shipping', fontSize: 16, color: ColorsFrave.secundaryColor),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextFrave(text: orderResponse.reference!, fontSize: 16, maxLine: 2)
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}