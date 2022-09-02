import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/products_top_home_response.dart';
import 'package:restaurant/domain/services/services.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/screens/client/client_home_screen.dart';
import 'package:restaurant/presentation/screens/client/details_product_screen.dart';

class SearchClientScreen extends StatefulWidget {
  
  @override
  _SearchClientScreenState createState() => _SearchClientScreenState();
}

class _SearchClientScreenState extends State<SearchClientScreen> {

  late TextEditingController _searchController;


  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){

    final productBloc = BlocProvider.of<ProductsBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushReplacement(context, routeFrave(page: ClientHomeScreen())),
                    child: Container(
                      height: 44,
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged:(value){
                          productBloc.add( OnSearchProductEvent(value));
                          if( value.length != 0 ) productServices.searchProductsForName(value);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search products',
                          hintStyle: GoogleFonts.getFont('Inter', color: Colors.grey)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (_, state) 
                  => Expanded(
                  child: ( state.searchProduct.length != 0 ) 
                    ? listProducts()
                    : _HistorySearch()
                  
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationFrave(1),
    );
  }

  Widget listProducts(){

    return StreamBuilder<List<Productsdb>>(
      stream: productServices.searchProducts,
      builder: (context, snapshot) {

        if( snapshot.data == null ) return _HistorySearch();
        
        if( !snapshot.hasData ) return Center(child: CircularProgressIndicator());

        if( snapshot.data!.length == 0 ) {
          return ListTile(
            title: TextCustom(text: 'Without results for ${_searchController.text}'),
          );
        }

        final listProduct = snapshot.data!;

        return _ListProductSearch(listProduct: listProduct);

      }
    );

  }

}

class _ListProductSearch extends StatelessWidget {

  final List<Productsdb> listProduct;

  const _ListProductSearch({required this.listProduct});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listProduct.length,
      itemBuilder: (context, i) 
        => Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: InkWell(
            onTap: () => Navigator.push(context, routeFrave(page: DetailsProductScreen(product: listProduct[i]))),
            child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        scale: 8,
                        image: NetworkImage('${Environment.endpointBase}${listProduct[i].picture}')
                      )
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCustom(text: listProduct[i].nameProduct),
                        const SizedBox(height: 5.0),
                        TextCustom(text: '\$ ${listProduct[i].price }', color: Colors.grey),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )      
    );
  }
}



class _HistorySearch extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const TextCustom(text: 'RECENT SEARCH', fontSize: 16, color: Colors.grey),
        const SizedBox(height: 10.0),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          minLeadingWidth: 20,
          leading: const Icon(Icons.history),
          title: const TextCustom(text: 'Burger', color: Colors.grey),
        )
      ],
    );
  }
}