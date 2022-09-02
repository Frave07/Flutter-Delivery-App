import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/type_payment.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/client/client_home_screen.dart';
import 'package:restaurant/presentation/screens/client/select_addreess_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class CheckOutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final orderBloc = BlocProvider.of<OrdersBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final paymentBloc = BlocProvider.of<PaymentsBloc>(context);

    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if(state is LoadingOrderState) {
          modalLoading(context);
        }
        if(state is SuccessOrdersState) {
          Navigator.pop(context);
          modalSuccess(context, 'order received', () {
            cartBloc.add(OnClearCartEvent());
            paymentBloc.add(OnClearTypePaymentMethodEvent());
            Navigator.pushAndRemoveUntil(context, routeFrave(page: ClientHomeScreen()), (route) => false);
          });
        }
        if(state is FailureOrdersState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: TextCustom(text: state.error, color: Colors.white),
              backgroundColor: Colors.red
            )
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          title: const TextCustom(text: 'Checkout', fontWeight: FontWeight.w500),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 19),
                TextCustom( text: 'Back ', fontSize: 17, color: ColorsFrave.primaryColor)
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CheckoutAddress(),
                const SizedBox(height: 20.0),
                _CheckoutPaymentMethods(),
                const SizedBox(height: 20.0),
                _DetailsTotal(),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<PaymentsBloc, PaymentsState>(
                      builder: (context, state) 
                        => InkWell(
                          onTap: (){
                            orderBloc.add(
                              OnAddNewOrdersEvent(
                                userBloc.state.uidAddress,
                                cartBloc.state.total,
                                paymentBloc.state.typePaymentMethod,
                                cartBloc.product
                              )
                            );

                            // if( state.typePaymentMethod == 'CREDIT CARD' ){

                            //   modalPaymentWithNewCard(ctx: context, amount: cartBloc.state.total.toString());

                            // }
                            
                          },
                          child: Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: state.colorPayment,
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(state.iconPayment, color: Colors.white),
                                const SizedBox(width: 10.0),
                                TextCustom(text: state.typePaymentMethod, color: Colors.white)                              
                              ],
                            ),
                          ),
                        )
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsTotal extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CartBloc>(context);

    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 190,
      decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextCustom(text: 'Order Summary', fontWeight: FontWeight.w500),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(text: 'Subtotal', color: Colors.grey),
              TextCustom(text: '\$ ${cardBloc.state.total}0', color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(text: 'IGV', color: Colors.grey),
              TextCustom(text: '\$ 2.5', color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(text: 'Shipping', color: Colors.grey),
              TextCustom(text: '\$ 0.00', color: Colors.grey),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(text: 'Total', fontWeight: FontWeight.w500),
              TextCustom(text: '\$ ${cardBloc.state.total}0', fontWeight: FontWeight.w500),
            ],
          ),
        ],
      ),
    );
  }
}

class _CheckoutPaymentMethods extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final paymentBloc = BlocProvider.of<PaymentsBloc>(context);

    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(text: 'Payment Methods', fontWeight: FontWeight.w500),
              BlocBuilder<PaymentsBloc, PaymentsState>(
                  builder: (_, state) => TextCustom(
                      text: state.typePaymentMethod,
                      color: ColorsFrave.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  )
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 5.0),
          Container(
            height: 80,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: TypePaymentMethod.listTypePayment.length,
              itemBuilder: (_, i) => InkWell(
                onTap: () => paymentBloc.add(OnSelectTypePaymentMethodEvent(
                    TypePaymentMethod.listTypePayment[i].typePayment, 
                    TypePaymentMethod.listTypePayment[i].icon, 
                    TypePaymentMethod.listTypePayment[i].color
                  )
                ),
                child: BlocBuilder<PaymentsBloc, PaymentsState>(
                  builder: (_, state) => Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                        color: (TypePaymentMethod.listTypePayment[i].typePayment == state.typePaymentMethod)
                            ? Color(0xffF7FAFC)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey[200]!)
                    ),
                    child: Icon(
                      TypePaymentMethod.listTypePayment[i].icon,
                      size: 40,
                      color: TypePaymentMethod.listTypePayment[i].color
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CheckoutAddress extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 95,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(text: 'Shipping Address', fontWeight: FontWeight.w500),
              InkWell(
                  onTap: () => Navigator.push(
                      context, routeFrave(page: SelectAddressScreen())),
                  child: const TextCustom(
                      text: 'Change',
                      color: ColorsFrave.primaryColor,
                      fontSize: 17))
            ],
          ),
          const Divider(),
          const SizedBox(height: 5.0),
          BlocBuilder<UserBloc, UserState>(
              builder: (_, state) => TextCustom(
                  text: (state.addressName != '')
                      ? state.addressName
                      : 'Select Address',
                  fontSize: 17,
                  maxLine: 1))
        ],
      ),
    );
  }
}
