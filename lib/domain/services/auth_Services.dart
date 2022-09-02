import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant/data/env/environment.dart';
import 'package:restaurant/data/local_secure/secure_storage.dart';
import 'package:restaurant/domain/models/response/response_login.dart';

class AuthServices {


  Future<ResponseLogin> loginController( String email, String password ) async {

    final response = await http.post(Uri.parse('${Environment.endpointApi}/login-email-id'),
      headers: { 'Accept' : 'application/json' },
      body: {
        'email' : email,
        'password' : password
      }
    );

    return ResponseLogin.fromJson(jsonDecode(response.body));
  }


  Future<ResponseLogin> renewLoginController() async {

    final token = await secureStorage.readToken();

    final response = await http.get(Uri.parse('${Environment.endpointApi}/renew-token-login'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return ResponseLogin.fromJson(jsonDecode(response.body));
  }


}

final authServices = AuthServices();