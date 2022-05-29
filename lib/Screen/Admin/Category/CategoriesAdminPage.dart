import 'package:flutter/material.dart';
import 'package:restaurant/Controller/CategoryController.dart';
import 'package:restaurant/Models/Response/CategoryAllResponse.dart';
import 'package:restaurant/Screen/Admin/Category/AddCategoryAdminPage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';

class CategoriesAdminPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextFrave(text: 'Categories'),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 17),
              TextFrave(text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor,)
            ],
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.push(context, routeFrave(page: AddCategoryAdminPage())), 
            child: const TextFrave(text: 'Add', color: ColorsFrave.primaryColor, fontSize: 17)
          )
        ],
      ),
      body: FutureBuilder<List<Category>>(
        future: categoryController.getAllCategories(),
        builder: (context, snapshot) 
          => !snapshot.hasData 
            ? Center(
              child: Row(
                children: const [
                  CircularProgressIndicator(),
                  TextFrave(text: 'Loading Categories...')
                ],
              ),
            )
            : _ListCategories(listCategory: snapshot.data! )
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {
  
  final List<Category> listCategory;

  const _ListCategories({ required this.listCategory});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      physics: const BouncingScrollPhysics(),
      itemCount: listCategory.length,
      itemBuilder: (_, i) 
        => Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: ColorsFrave.primaryColor, width: 4.5)
                  ),
                ),
                const SizedBox(width: 20.0),
                TextFrave(text: listCategory[i].category),
              ],
            ),
          ),
        ),
    );
  }
}