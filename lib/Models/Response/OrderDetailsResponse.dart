import 'dart:convert';

OrderDetailsResponse orderDetailsResponseFromJson(String str) => OrderDetailsResponse.fromJson(json.decode(str));

String orderDetailsResponseToJson(OrderDetailsResponse data) => json.encode(data.toJson());

class OrderDetailsResponse {

    bool? resp;
    String? msg;
    List<DetailsOrder>? detailsOrder;

    OrderDetailsResponse({
        this.resp,
        this.msg,
        this.detailsOrder,
    });    

    factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => OrderDetailsResponse(
        resp: json["resp"],
        msg: json["msg"],
        detailsOrder: List<DetailsOrder>.from(json["detailsOrder"].map((x) => DetailsOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "detailsOrder": List<dynamic>.from(detailsOrder!.map((x) => x.toJson())),
    };
}

class DetailsOrder {

    int? id;
    int? orderId;
    int? productId;
    String? nameProduct;
    String? picture;
    int? quantity;
    double? total;

    DetailsOrder({
        this.id,
        this.orderId,
        this.productId,
        this.nameProduct,
        this.picture,
        this.quantity,
        this.total,
    });
    

    factory DetailsOrder.fromJson(Map<String, dynamic> json) => DetailsOrder(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        nameProduct: json["nameProduct"],
        picture: json["picture"],
        quantity: json["quantity"],
        total: json["total"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "nameProduct": nameProduct,
        "picture": picture,
        "quantity": quantity,
        "total": total,
    };
}
