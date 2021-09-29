import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Bloc/Products/products_bloc.dart';
import 'package:restaurant/Controller/ProductsController.dart';
import 'package:restaurant/Helpers/Helpers.dart';
import 'package:restaurant/Models/Response/ProductsTopHomeResponse.dart';
import 'package:restaurant/Screen/Admin/Products/AddNewProductPage.dart';
import 'package:restaurant/Services/url.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';


class ListProductsPage extends StatefulWidget {
  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        
        if( state is LoadingProductsState ){

          modalLoading(context);

        }else if( state is SuccessProductsState ){

          Navigator.pop(context);
          modalSuccess(context, 'Success', (){
            Navigator.pop(context);
            setState(() {});
          });

        } else if ( state is FailureProductsState ){

          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFrave(text: 'List Products', fontSize: 19),
          centerTitle: true,
          leadingWidth: 80,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 17),
                TextFrave(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor)
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.push(context, routeFrave(page: AddNewProductPage())), 
              child: TextFrave(text: 'Add', fontSize: 17, color: ColorsFrave.primaryColor)
            )
          ],
        ),
        body: FutureBuilder<List<Productsdb>>(
          future: productController.listProductsAdmin(),
          builder: (context, snapshot) 
            => ( !snapshot.hasData )
              ? ShimmerFrave()
              : _GridViewListProduct(listProducts: snapshot.data!)
           
        ),
      ),
    );
  }
}

class _GridViewListProduct extends StatelessWidget {
  
  final List<Productsdb> listProducts;

  const _GridViewListProduct({required this.listProducts});

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: listProducts.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ), 
      itemBuilder: (context, i) 
        => InkWell(
          onTap: () => modalActiveOrInactiveProduct(context, listProducts[i].status, listProducts[i].nameProduct, listProducts[i].id, listProducts[i].picture),
          onLongPress: () => modalDeleteProduct(context, listProducts[i].nameProduct, listProducts[i].picture, listProducts[i].id.toString()),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 7,
                    image: NetworkImage( URLS.BASE_URL + listProducts[i].picture)
                  )
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: ( listProducts[i].status == 1 ) ? Colors.grey[50] : Colors.red[100]
                  ),
                  child: TextFrave(text: listProducts[i].nameProduct, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
    );  

  }



}