import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:restaurant/Bloc/Products/products_bloc.dart';
import 'package:restaurant/Screen/Admin/Category/CategoriesAdminPage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';
import 'package:restaurant/Helpers/Helpers.dart';

class AddCategoryAdminPage extends StatefulWidget {
  @override
  _AddCategoryAdminPageState createState() => _AddCategoryAdminPageState();
}

class _AddCategoryAdminPageState extends State<AddCategoryAdminPage> {

  late TextEditingController _nameCategoryController;
  late TextEditingController _categoryDescriptionController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameCategoryController = TextEditingController();
    _categoryDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameCategoryController.clear();
    _categoryDescriptionController.clear();
    _nameCategoryController.dispose();
    _categoryDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final productBloc = BlocProvider.of<ProductsBloc>(context);

    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {

        if( state is LoadingProductsState ){
          modalLoading(context);
        
        } else if ( state is SuccessProductsState ) {
          Navigator.pop(context);
          Navigator.pushReplacement(context, routeFrave(page: CategoriesAdminPage()));
        
        } else if ( state is FailureProductsState ){

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextFrave(text: state.error, color: Colors.white), backgroundColor: Colors.red ));
        }

      } ,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFrave(text: 'Add Category'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor , size: 17),
                TextFrave(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor )
              ],
            ),
          ),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                if( _keyForm.currentState!.validate() ){
                  productBloc.add(OnAddNewCategoryEvent(_nameCategoryController.text, _categoryDescriptionController.text));
                }
              }, 
              child: TextFrave(text: 'Save', color: ColorsFrave.primaryColor )
            )
          ],
        ),
        body: Form(
          key: _keyForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                TextFrave(text: 'Category name'),
                SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _nameCategoryController,
                  hintText: 'Drinks',
                  validator: RequiredValidator(errorText: 'Category name is required'),
                ),
                SizedBox(height: 25.0),
                TextFrave(text: 'Category Description'),
                SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _categoryDescriptionController,
                  maxLine: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}