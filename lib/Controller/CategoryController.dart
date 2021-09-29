import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant/Helpers/secure_storage.dart';
import 'package:restaurant/Models/Response/CategoryAllResponse.dart';
import 'package:restaurant/Models/Response/ResponseDefault.dart';
import 'package:restaurant/Services/url.dart';

class CategoryController {


  Future<ResponseDefault> addNewCategory(String nameCategory, String descriptionCategory) async {

    final token = await secureStorage.readToken();

    final response = await http.post(Uri.parse('${URLS.URL_API}/add-categories'),
      headers: {  'Accept' : 'application/json', 'xx-token' : token! },
      body: {
        'category' : nameCategory,
        'description' : descriptionCategory
      }
    );

    return ResponseDefault.fromJson( jsonDecode( response.body ) );
  } 


  Future<List<Category>> getAllCategories() async {

    final token = await secureStorage.readToken();

    final response = await http.get(Uri.parse('${URLS.URL_API}/get-all-categories'),
      headers: {  'Accept' : 'application/json', 'xx-token' : token! }
    );

    return CategoryAllResponse.fromJson( jsonDecode( response.body )).categories;
  }


  Future<ResponseDefault> deleteCategory(String uidCategory) async {

    final token = await secureStorage.readToken();

    final resp = await http.delete(Uri.parse('${URLS.URL_API}/delete-category/'+ uidCategory ),
      headers: { 'Content-type' : 'application/json', 'xx-token' : token! }
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ) );

  }

  

}

final categoryController = CategoryController();