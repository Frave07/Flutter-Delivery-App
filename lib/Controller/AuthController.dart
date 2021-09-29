import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant/Helpers/secure_storage.dart';
import 'package:restaurant/Models/Response/ResponseLogin.dart';
import 'package:restaurant/Services/url.dart';

class AuthController {


    Future<ResponseLogin> loginController( String email, String password ) async {

      final response = await http.post(Uri.parse('${URLS.URL_API}/login-email-id'),
        headers: { 'Accept' : 'application/json' },
        body: {
          'email' : email,
          'password' : password
        }
      );

      return ResponseLogin.fromJson( jsonDecode( response.body ) );
    }


    Future<ResponseLogin> renewLoginController() async {

      final token = await secureStorage.readToken();

      final response = await http.get(Uri.parse('${URLS.URL_API}/renew-token-login'),
        headers: { 'Accept' : 'application/json', 'xx-token' : token! }
      );

      return ResponseLogin.fromJson( jsonDecode( response.body ) );
    }


}

final authController = AuthController();