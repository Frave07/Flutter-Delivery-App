import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/order_details_response.dart';
import 'package:restaurant/domain/models/response/orders_by_status_response.dart';
import 'package:restaurant/domain/services/orders_services.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/date_custom.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/admin/orders_admin/orders_admin_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';


class OrderDetailsScreen extends StatelessWidget {

  final OrdersResponse order;

  const OrderDetailsScreen({ required this.order });


  @override
  Widget build(BuildContext context) {

    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if( state is LoadingOrderState ){
          modalLoading(context);
        }else if( state is SuccessOrdersState ){
          Navigator.pop(context);
          modalSuccess(context, 'DISPATCHED', () => Navigator.pushReplacement(context, routeFrave(page: OrdersAdminScreen())));
        } else if( state is FailureOrdersState ){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextCustom(text: state.error, color: Colors.white), backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextCustom(text: 'Order N° ${order.orderId}'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios_new_rounded, size: 17, color: ColorsFrave.primaryColor ),
                TextCustom(text: 'Back', color: ColorsFrave.primaryColor, fontSize: 17)
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: FutureBuilder<List<DetailsOrder>>(
                future: ordersServices.gerOrderDetailsById('${order.orderId}'),
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
                    : _ListProductsDetails(listProductDetails: snapshot.data!)
                
              )
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'Total', color: ColorsFrave.secundaryColor, fontSize: 22, fontWeight: FontWeight.w500),
                        TextCustom(text: '\$ ${order.amount}0', fontSize: 22, fontWeight: FontWeight.w500),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'Cliente:', color: ColorsFrave.secundaryColor, fontSize: 16),
                        TextCustom(text: '${order.cliente}'),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'Date:', color: ColorsFrave.secundaryColor, fontSize: 16),
                        TextCustom(text: DateCustom.getDateOrder(order.currentDate.toString()), fontSize: 16),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const TextCustom(text: 'Address shipping:', color: ColorsFrave.secundaryColor, fontSize: 16),
                    const SizedBox(height: 5.0),
                    TextCustom(text: order.reference, maxLine: 2, fontSize: 16),
                    const SizedBox(height: 5.0),
                    (order.status == 'DISPATCHED')
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(text: 'Delivery', fontSize: 17, color: ColorsFrave.secundaryColor),
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('${Environment.endpointBase}${order.deliveryImage}')
                                )
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            TextCustom(text: order.delivery, fontSize: 17)
                          ],
                        )
                      ],
                    ) : const SizedBox()
                  ],
                ),
              )
            ),
            (order.status == 'PAID OUT')
            ? Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BtnFrave(
                    text: 'SELECT DELIVERY',
                    fontWeight: FontWeight.w500,
                    onPressed: () => modalSelectDelivery(context, order.orderId.toString()),
                  ) 
                ],
              ),
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class _ListProductsDetails extends StatelessWidget {
  
  final List<DetailsOrder> listProductDetails;

  const _ListProductsDetails({required this.listProductDetails});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: listProductDetails.length,
      separatorBuilder: (_, index) => Divider(),
      itemBuilder: (_, i) 
        => Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${Environment.endpointBase}${listProductDetails[i].picture}')
                  )
                ),
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(text: listProductDetails[i].nameProduct, fontWeight: FontWeight.w500 ),
                  const SizedBox(height: 5.0),
                  TextCustom(text: 'Quantity: ${listProductDetails[i].quantity}', color: Colors.grey, fontSize: 17),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextCustom(text: '\$ ${listProductDetails[i].total}'),
                )
              )
            ],
          ),
        ),
    );
  }
}

