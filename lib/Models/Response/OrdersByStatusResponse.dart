import 'dart:convert';

OrdersByStatusResponse ordersByStatusResponseFromJson(String str) => OrdersByStatusResponse.fromJson(json.decode(str));

String ordersByStatusResponseToJson(OrdersByStatusResponse data) => json.encode(data.toJson());

class OrdersByStatusResponse {
    

    bool? resp;
    String? msg;
    List<OrdersResponse>? ordersResponse;

    OrdersByStatusResponse({
        this.resp,
        this.msg,
        this.ordersResponse,
    });

    factory OrdersByStatusResponse.fromJson(Map<String, dynamic> json) => OrdersByStatusResponse(
        resp: json["resp"],
        msg: json["msg"],
        ordersResponse: List<OrdersResponse>.from(json["ordersResponse"].map((x) => OrdersResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "ordersResponse": List<dynamic>.from(ordersResponse!.map((x) => x.toJson())),
    };
}

class OrdersResponse {

    int? orderId;
    int? deliveryId;
    String? delivery;
    String? deliveryImage;
    int? clientId;
    String? cliente;
    String? clientImage;
    String? clientPhone;
    int? addressId;
    String? street;
    String? reference;
    String? latitude;
    String? longitude;
    String? status;
    String? payType;
    double? amount;
    DateTime? currentDate;

    OrdersResponse({
        this.orderId,
        this.deliveryId,
        this.delivery,
        this.deliveryImage,
        this.clientId,
        this.cliente,
        this.clientImage,
        this.clientPhone,
        this.addressId,
        this.street,
        this.reference,
        this.latitude,
        this.longitude,
        this.status,
        this.payType,
        this.amount,
        this.currentDate,
    });

    

    factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        orderId: json["order_id"],
        deliveryId: json["delivery_id"] != null ? json["delivery_id"] : 0,
        delivery: json["delivery"] != null ? json["delivery"] : '',
        deliveryImage: json["deliveryImage"] != null ? json["deliveryImage"] : '',
        clientId: json["client_id"],
        cliente: json["cliente"],
        clientImage: json["clientImage"],
        clientPhone: json["clientPhone"] != null ? json["clientPhone"] : '',
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

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "delivery_id": deliveryId,
        "delivery": delivery,
        "deliveryImage": deliveryImage,
        "client_id": clientId,
        "cliente": cliente,
        "clientImage": clientImage,
        "clientPhone": clientPhone,
        "address_id": addressId,
        "street": street,
        "reference": reference,
        "Latitude": latitude,
        "Longitude": longitude,
        "status": status,
        "pay_type": payType,
        "amount": amount,
        "currentDate": currentDate!.toIso8601String(),
    };
}
