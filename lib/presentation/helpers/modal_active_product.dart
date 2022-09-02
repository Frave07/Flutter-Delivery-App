import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';


void modalActiveOrInactiveProduct(BuildContext context, int status, String nameProduct, int idProduct, String picture){

  final productBloc = BlocProvider.of<ProductsBloc>(context);

  showDialog(
    context: context,
    barrierColor: Colors.white54, 
    builder: (context) 
      => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: SizedBox(
          height: 155,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      TextCustom(text: 'Frave ', color: ColorsFrave.primaryColor, fontWeight: FontWeight.w500 ),
                      TextCustom(text: 'Food', fontWeight: FontWeight.w500),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close)
                  )
                ],
              ),
              const Divider(),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        scale: 7,
                        image: NetworkImage('${Environment.endpointBase}$picture')
                      )
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  TextCustom(
                    text: nameProduct,
                    maxLine: 2,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              BtnFrave(
                height: 45,
                text: (status == 1) ? 'SOLD OUT' : 'IN STOCK',
                color: (status == 1) ? Colors.red : Colors.green,
                onPressed: () {
                  productBloc.add( OnUpdateStatusProductEvent( idProduct.toString(), (status == 1) ? '0' : '1' ) );
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
  );

}