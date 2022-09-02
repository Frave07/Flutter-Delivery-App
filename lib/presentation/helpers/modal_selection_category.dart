import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/category_all_response.dart';
import 'package:restaurant/domain/services/services.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

void modalSelectionCategory(BuildContext ctx){

  final productBloc = BlocProvider.of<ProductsBloc>(ctx);

  showModalBottomSheet(
    context: ctx,
    barrierColor: Colors.black26,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
    builder: (ctx)
      => Container(
        height: 470,
        padding: const EdgeInsets.all(20.0),
        width: MediaQuery.of(ctx).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.grey[300]
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Select Category', fontWeight: FontWeight.w500, fontSize: 19),
            const SizedBox(height: 10.0),
            Expanded(
              child: FutureBuilder<List<Category>>(
              future: categoryServices.getAllCategories(),
              builder: (_, snapshot) {

                final List<Category>? category = snapshot.data;

                 return !snapshot.hasData 
                    ? Center(
                        child: const CircularProgressIndicator(),
                      )
                    : Container(
                      height: 350,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) 
                          => InkWell(
                            onTap: () => productBloc.add(OnSelectCategoryEvent(category[i].id, category[i].category)),
                            child: Container(
                                height: 40,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: ColorsFrave.primaryColor, width: 3.5),
                                            borderRadius: BorderRadius.circular(6.0)
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        TextCustom(text: category![i].category)
                                      ],
                                    ),
                                    BlocBuilder<ProductsBloc, ProductsState>(
                                      builder: (context, state) 
                                        => state.idCategory == category[i].id ? Icon(Icons.check) : Container(),
                                    )
                                  ],
                                ),
                            ),
                          ),
                      ),
                    );
                }
              )
            )
          ],
        ),
      ),
  );

}