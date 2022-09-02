import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/admin/category/categories_admin_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class AddCategoryAdminScreen extends StatefulWidget {
  
  @override
  _AddCategoryAdminScreenState createState() => _AddCategoryAdminScreenState();
}

class _AddCategoryAdminScreenState extends State<AddCategoryAdminScreen> {

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
  Widget build(BuildContext context) {

    final productBloc = BlocProvider.of<ProductsBloc>(context);

    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if( state is LoadingProductsState ){
          modalLoading(context);
        }
        if(state is SuccessProductsState ) {
          Navigator.pop(context);
          Navigator.pushReplacement(context, routeFrave(page: CategoriesAdminScreen()));
        }
        if( state is FailureProductsState ){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextCustom(text: state.error, color: Colors.white), backgroundColor: Colors.red ));
        }
      } ,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Add Category'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor , size: 17),
                TextCustom(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor )
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
              child: const TextCustom(text: 'Save', color: ColorsFrave.primaryColor )
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
                const SizedBox(height: 20.0),
                const TextCustom(text: 'Category name'),
                const SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _nameCategoryController,
                  hintText: 'Drinks',
                  validator: RequiredValidator(errorText: 'Category name is required'),
                ),
                const SizedBox(height: 25.0),
                const TextCustom(text: 'Category Description'),
                const SizedBox(height: 5.0),
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