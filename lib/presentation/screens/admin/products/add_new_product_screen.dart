import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/admin/admin_home_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class AddNewProductScreen extends StatefulWidget {

  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.clear();
    _nameController.dispose();
    _descriptionController.clear();
    _descriptionController.dispose();
    _priceController.clear();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final productBloc = BlocProvider.of<ProductsBloc>(context);

    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if(state is LoadingProductsState ){
          modalLoading(context);
        }
        if(state is SuccessProductsState ){
          Navigator.pop(context);
          modalSuccess(context, 'Product added Successfully', () => Navigator.pushReplacement(context, routeFrave(page: AdminHomeScreen())));
        }
        if(state is FailureProductsState ){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextCustom(text: state.error, color: Colors.white), backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Add New Product'),
          centerTitle: true,
          leadingWidth: 80,
          leading: TextButton(
            child: const TextCustom(text: 'Cancel', color: ColorsFrave.primaryColor, fontSize: 17),
            onPressed: (){
              Navigator.pop(context);
              productBloc.add(OnUnSelectCategoryEvent());
              productBloc.add(OnUnSelectMultipleImagesEvent());
            },
          ),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                productBloc.add(OnAddNewProductEvent(
                  _nameController.text, 
                  _descriptionController.text, 
                  _priceController.text, 
                  productBloc.state.images!, 
                  productBloc.state.idCategory.toString()
                ));
              }, 
              child: const TextCustom(text: ' Save ', color: ColorsFrave.primaryColor )
            )
          ],
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              const SizedBox(height: 10.0),
              const TextCustom(text: 'Product name'),
              const SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _nameController,
                hintText: 'Product',
                validator: RequiredValidator(errorText: 'Name is required'),
              ),
              const SizedBox(height: 20.0),
              const TextCustom(text: 'Product description'),
              const SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _descriptionController,
                maxLine: 5,
                validator: RequiredValidator(errorText: 'Description is required'),
              ),
              const SizedBox(height: 20.0),
              const TextCustom(text: 'Price'),
              const SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _priceController,
                hintText: '\$ 0.00',
                keyboardType: TextInputType.number,
                validator: RequiredValidator(errorText: 'Price is required'),
              ),
              const SizedBox(height: 20.0),
              const TextCustom(text: 'Pictures'),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () async {
    
                  final ImagePicker _picker = ImagePicker();
    
                  final List<XFile>? images = await _picker.pickMultiImage();
    
                  if(images != null)  productBloc.add(OnSelectMultipleImagesEvent(images));
    
                },
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) 
                      => state.images != null
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.images?.length,
                            itemBuilder: (_, i) 
                              => Container(
                                height: 100,
                                width: 120,
                                margin: const EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(state.images![i].path)),
                                    fit: BoxFit.cover
                                  )
                                ),
                              )
                          )
                        : const Icon(Icons.wallpaper_rounded, size: 80, color: Colors.grey)
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const TextCustom(text: 'Category'),
              const SizedBox(height: 5.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 7, spreadRadius: -5.0)
                    ]
                  ),
                  child: InkWell(
                    onTap: () => modalSelectionCategory(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 3.5),
                                borderRadius: BorderRadius.circular(6.0)
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) 
                                => state.category == null || state.category == '' ? TextCustom(text: 'Select Category') : TextCustom(text: state.category!),
                            )
                          ],
                        ),
                        const Icon(Icons.navigate_next_rounded)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}