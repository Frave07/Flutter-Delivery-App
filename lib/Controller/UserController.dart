import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant/Helpers/secure_storage.dart';
import 'package:restaurant/Models/Response/AddressOneResponse.dart';
import 'package:restaurant/Models/Response/AddressesResponse.dart';
import 'package:restaurant/Models/Response/ResponseDefault.dart';
import 'package:restaurant/Models/Response/ResponseLogin.dart';
import 'package:restaurant/Models/Response/UserUpdatedResponse.dart';
import 'package:restaurant/Services/url.dart';
import 'package:restaurant/main.dart';

class UserController {


  Future<User?> getUserById() async {

    final token = await secureStorage.readToken();
    
    final response = await http.get(Uri.parse('${URLS.URL_API}/get-user-by-id'),
      headers: {  'Accept' : 'application/json', 'xx-token' : token! }
    );

    return ResponseLogin.fromJson( jsonDecode( response.body ) ).user;

  }


  Future<ResponseDefault> editProfile(String name, String lastname, String phone ) async {

    final token = await secureStorage.readToken();

    final response = await http.put(Uri.parse('${URLS.URL_API}/edit-profile'),
      headers: {  'Accept' : 'application/json', 'xx-token' : token! },
      body: {
        'firstname' : name,
        'lastname' : lastname,
        'phone': phone
      }
    );

    return ResponseDefault.fromJson( jsonDecode( response.body ));
  }


  Future<UserUpdated> getUserUpdated() async {

    final token = await secureStorage.readToken();

    final response = await http.get(Uri.parse('${URLS.URL_API}/get-user-updated'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );
    
    return UserUpdatedResponse.fromJson( jsonDecode( response.body ) ).user;
  }


  Future<ResponseDefault> changePassword(String currentPassword, String newPassword) async {

    final token = await secureStorage.readToken();

    final response = await http.put(Uri.parse('${URLS.URL_API}/change-password'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
      body: {
        'currentPassword' : currentPassword,
        'newPassword' : newPassword
      }
    );

    return ResponseDefault.fromJson(jsonDecode( response.body ));
  }


  Future<ResponseDefault> changeImageProfile(String image) async {

    final token = await secureStorage.readToken();

    var request = http.MultipartRequest('PUT', Uri.parse('${URLS.URL_API}/change-image-profile'))
        ..headers['Accept'] = 'application/json'
        ..headers['xx-token'] = token!
        ..files.add( await http.MultipartFile.fromPath('image', image));

      final response = await request.send();
      var data = await http.Response.fromStream( response );

      return ResponseDefault.fromJson( jsonDecode( data.body ));
  }

  
  Future<ResponseDefault> registerDelivery(String name, String lastname, String phone, String email, String password, String image, String nToken ) async {

      final token = await secureStorage.readToken();

      var request = http.MultipartRequest('POST', Uri.parse('${URLS.URL_API}/register-delivery'))
        ..headers['Accept'] = 'application/json'
        ..headers['xx-token'] = token!
        ..fields['firstname'] = name
        ..fields['lastname'] = lastname
        ..fields['phone'] = phone
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['notification_token'] = nToken
        ..files.add( await http.MultipartFile.fromPath('image', image));

      final response = await request.send();
      var data = await http.Response.fromStream( response );

      return ResponseDefault.fromJson( jsonDecode( data.body ));

  }


  Future<ResponseDefault> registerClient( String name, String lastname, String phone, String image, String email, String password, String nToken ) async {

      var request = http.MultipartRequest('POST', Uri.parse('${URLS.URL_API}/register-client'))
        ..headers['Accept'] = 'application/json'
        ..fields['firstname'] = name
        ..fields['lastname'] = lastname
        ..fields['phone'] = phone
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['notification_token'] = nToken
        ..files.add( await http.MultipartFile.fromPath('image', image));

      final response = await request.send();
      var data = await http.Response.fromStream( response );

      return ResponseDefault.fromJson( jsonDecode( data.body ));
    }


  Future<List<ListAddress>?> getAddresses() async {

    final token = await secureStorage.readToken();

    final response = await http.get(Uri.parse('${URLS.URL_API}/get-addresses'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return AddressesResponse.fromJson( jsonDecode(response.body) ).listAddresses;
  }


  Future<ResponseDefault> deleteStreetAddress(String idAddress ) async {

    final token = await secureStorage.readToken();

    final resp = await http.delete(Uri.parse('${URLS.URL_API}/delete-street-address/'+ idAddress),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ));
  }


  Future<ResponseDefault> addNewAddressLocation(String street, String reference, String latitude, String longitude) async {

    final token = await secureStorage.readToken();

    final resp = await http.post(Uri.parse('${URLS.URL_API}/add-new-address'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
      body: {
        'street'    : street,
        'reference' : reference,
        'latitude'  : latitude,
        'longitude' : longitude
      }
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ) );

  }


  Future<AddressOneResponse> getAddressOne() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-address'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return AddressOneResponse.fromJson( jsonDecode( resp.body ) );

  }


  Future<ResponseDefault> updateNotificationToken() async {

    final token = await secureStorage.readToken();
    final nToken = await pushNotification.getNotificationToken();

    final resp = await http.put(Uri.parse('${URLS.URL_API}/update-notification-token'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
      body: {
        'nToken' : nToken
      }
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ) );

  }


  Future<List<String>> getAdminsNotificationToken() async {

    final token = await secureStorage.readToken();
    
    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-admins-notification-token'),
      headers: {'Accept' : 'application/json', 'xx-token' : token! }
    );
    
    return List<String>.from( jsonDecode( resp.body ));

  }


  Future<ResponseDefault> updateDeliveryToClient(String idPerson) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${URLS.URL_API}/update-delivery-to-client/' + idPerson),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ) );

  }


}

final userController = UserController();