import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/screens/client/check_out_screen.dart';
import 'package:restaurant/presentation/screens/client/client_home_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class CartClientScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextCustom(text: 'My Bag', fontSize: 20, fontWeight: FontWeight.w500 ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: IconButton(
          icon: Row(
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 19),
              TextCustom(text: 'Back', fontSize: 16, color: ColorsFrave.primaryColor )
            ],
          ),
          onPressed: () => Navigator.pushAndRemoveUntil(context, routeFrave(page: ClientHomeScreen()), (route) => false),
        ),
        actions: [
          Center(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) 
                => TextCustom(text: '${state.quantityCart} Items', fontSize: 17 )
            )
          ),
          const SizedBox(width: 10.0)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) 
                  => (state.quantityCart != 0 ) 
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: state.quantityCart,
                        itemBuilder: (_, i) 
                          => Dismissible(
                            key: Key(state.products![i].uidProduct),
                            direction: DismissDirection.endToStart,
                            background: Container(),
                            secondaryBackground: Container(
                              padding: const EdgeInsets.only(right: 35.0),
                              margin: const EdgeInsets.only(bottom: 15.0),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                              ),
                              child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 40),
                            ),
                            onDismissed: (direccion) => cartBloc.add(OnDeleteProductToCartEvent(i)),
                            child: Container(
                                height: 90,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          scale: 8,
                                          image: NetworkImage('${Environment.endpointBase}${state.products![i].imageProduct}')
                                        )
                                      ),
                                    ),
                                    Container(
                                      width: 130,
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextCustom(text: state.products![i].nameProduct, fontWeight: FontWeight.w500, fontSize: 20),
                                          const SizedBox(height: 10.0),
                                          TextCustom(text: '\$ ${state.products![i].price * state.products![i].quantity}', color: ColorsFrave.primaryColor )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                color: ColorsFrave.primaryColor,
                                                shape: BoxShape.circle
                                              ),
                                              child: InkWell(
                                                child: Icon(Icons.remove, color: Colors.white ),
                                                onTap: (){ 
                                                  if( state.products![i].quantity > 1 ) cartBloc.add(OnDecreaseProductQuantityToCartEvent(i)); 
                                                },
                                              )
                                            ),
                                            const SizedBox(width: 10.0),
                                            TextCustom(text: '${state.products![i].quantity}', color: ColorsFrave.primaryColor ),
                                            const SizedBox(width: 10.0),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                color: ColorsFrave.primaryColor,
                                                shape: BoxShape.circle
                                              ),
                                              child: InkWell(
                                                child: const Icon(Icons.add, color: Colors.white ),
                                                onTap: () => cartBloc.add(OnIncreaseQuantityProductToCartEvent(i))
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          )
                    )
                    : _WithOutProducts()
              ),
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) 
                    => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextCustom(text: 'Total'),
                          TextCustom(text: '${state.total}'),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextCustom(text: 'Sub Total'),
                          TextCustom(text: '${state.total}'),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      BtnFrave(
                        text: 'Checkout',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: (state.quantityCart != 0) ? ColorsFrave.primaryColor : ColorsFrave.secundaryColor,
                        onPressed: (){
                          if ( state.quantityCart != 0 ){
                            Navigator.push(context, routeFrave(page: CheckOutScreen()));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WithOutProducts extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('Assets/empty-cart.svg', height: 450),
        const TextCustom(text: 'Without products', fontSize: 21, fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor,)
      ],
    );
  }
}