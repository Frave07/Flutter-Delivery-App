import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant/Helpers/secure_storage.dart';
import 'package:restaurant/Models/ProductCart.dart';
import 'package:restaurant/Models/Response/OrderDetailsResponse.dart';
import 'package:restaurant/Models/Response/OrdersByStatusResponse.dart';
import 'package:restaurant/Models/Response/OrdersClientResponse.dart';
import 'package:restaurant/Models/Response/ResponseDefault.dart';
import 'package:restaurant/Services/url.dart';


class OrdersController {


  Future<ResponseDefault> addNewOrders(int uidAddress, double total, String typePayment, List<ProductCart> products) async {

    final token = await secureStorage.readToken();

    Map<String, dynamic> data = {
      "uidAddress"  : uidAddress,
      "typePayment": typePayment,
      "total"       : total,
      "products"    : products 
    };

    final body = json.encode( data );

    print(body);

    final resp = await http.post(Uri.parse('${URLS.URL_API}/add-new-orders'),
      headers: { 'Content-type' : 'application/json', 'xx-token' : token! },
      body: body
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ) );

  }


  Future<List<OrdersResponse>?> getOrdersByStatus( String status ) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-orders-by-status/'+ status),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
    );

    return OrdersByStatusResponse.fromJson( jsonDecode( resp.body ) ).ordersResponse;
  }


  Future<List<DetailsOrder>?> gerOrderDetailsById( String idOrder ) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-details-order-by-id/'+ idOrder),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
    );

    return OrderDetailsResponse.fromJson( jsonDecode( resp.body ) ).detailsOrder;
  }


  Future<ResponseDefault> updateStatusOrderToDispatched( String idOrder, String idDelivery ) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${URLS.URL_API}/update-status-order-dispatched'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
      body: {
        'idDelivery' : idDelivery,
        'idOrder' : idOrder
      }
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ));
  }


  Future<ResponseDefault> updateOrderStatusOnWay( String idOrder, String latitude, String longitude ) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${URLS.URL_API}/update-status-order-on-way/'+ idOrder),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
      body: {
        'latitude' : latitude,
        'longitude' : longitude
      }
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ));
  }
  

  Future<ResponseDefault> updateOrderStatusDelivered( String idOrder ) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${URLS.URL_API}/update-status-order-delivered/'+ idOrder),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ));
  }
  

  Future<List<OrdersClient>?> getListOrdersForClient() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-list-orders-for-client'),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );
    
    return OrdersClientResponse.fromJson( jsonDecode( resp.body ) ).ordersClient;
  }



}

final ordersController = OrdersController();