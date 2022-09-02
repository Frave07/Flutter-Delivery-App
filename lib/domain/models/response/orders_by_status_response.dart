
class OrdersByStatusResponse {

  final bool resp;
  final String msg;
  final List<OrdersResponse> ordersResponse;

  OrdersByStatusResponse({
    required this.resp,
    required this.msg,
    required this.ordersResponse,
  });

  factory OrdersByStatusResponse.fromJson(Map<String, dynamic> json) => OrdersByStatusResponse(
    resp: json["resp"],
    msg: json["msg"],
    ordersResponse: json["ordersResponse"] != null ? List<OrdersResponse>.from(json["ordersResponse"].map((x) => OrdersResponse.fromJson(x))) : [],
  );
}

class OrdersResponse {

  final int orderId;
  final int deliveryId;
  final String delivery;
  final String deliveryImage;
  final int clientId;
  final String cliente;
  final String clientImage;
  final String clientPhone;
  final int addressId;
  final String street;
  final String reference;
  final String latitude;
  final String longitude;
  final String status;
  final String payType;
  final double amount;
  final DateTime currentDate;

  OrdersResponse({
    required this.orderId,
    required this.deliveryId,
    required this.delivery,
    required this.deliveryImage,
    required this.clientId,
    required this.cliente,
    required this.clientImage,
    required this.clientPhone,
    required this.addressId,
    required this.street,
    required this.reference,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.payType,
    required this.amount,
    required this.currentDate,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
    orderId: json["order_id"],
    deliveryId: json["delivery_id"] ?? 0,
    delivery: json["delivery"] ?? '',
    deliveryImage: json["deliveryImage"] ?? '',
    clientId: json["client_id"],
    cliente: json["cliente"],
    clientImage: json["clientImage"],
    clientPhone: json["clientPhone"] ?? '',
    addressId: json["address_id"],
    street: json["street"],
    reference: json["reference"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    status: json["status"],
    payType: json["pay_type"],
    amount: json["amount"].toDouble(),
    currentDate: DateTime.parse(json["currentDate"]),
  );
}
