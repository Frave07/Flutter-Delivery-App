
class OrdersClientResponse {

  final bool resp;
  final String msg;
  final List<OrdersClient> ordersClient;

  OrdersClientResponse({
    required this.resp,
    required this.msg,
    required this.ordersClient,
  });

  factory OrdersClientResponse.fromJson(Map<String, dynamic> json) => OrdersClientResponse(
    resp: json["resp"],
    msg: json["msg"],
    ordersClient: json["ordersClient"] != null ? List<OrdersClient>.from(json["ordersClient"].map((x) => OrdersClient.fromJson(x))) : [],
  );
}

class OrdersClient {

  final int id;
  final int clientId;
  final int deliveryId;
  final String reference;
  final String latClient;
  final String lngClient;
  final String delivery;
  final String deliveryPhone;
  final String imageDelivery;
  final int addressId;
  final String latitude;
  final String longitude;
  final String status;
  final double amount;
  final String payType;
  final DateTime currentDate;

  OrdersClient({
    required this.id,
    required this.clientId,
    required this.deliveryId,
    required this.reference,
    required this.latClient,
    required this.lngClient,
    required this.delivery,
    required this.deliveryPhone,
    required this.imageDelivery,
    required this.addressId,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.amount,
    required this.payType,
    required this.currentDate,
  });

  factory OrdersClient.fromJson(Map<String, dynamic> json) => OrdersClient(
    id: json["id"],
    clientId: json["client_id"],
    deliveryId: json["delivery_id"] == null ? 0 : json["delivery_id"],
    delivery: json["delivery"] == null ? '' : json["delivery"],
    deliveryPhone: json["deliveryPhone"] == '' ? null : json["deliveryPhone"],
    imageDelivery: json["imageDelivery"] == '' ? null : json["imageDelivery"],
    addressId: json["address_id"],
    reference: json["reference"],
    latClient: json["latClient"],
    lngClient: json["lngClient"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"],
    amount: json["amount"].toDouble(),
    payType: json["pay_type"],
    currentDate: DateTime.parse(json["currentDate"]),
  );
}
