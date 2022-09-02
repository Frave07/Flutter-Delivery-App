
class OrderDetailsResponse {

  final bool resp;
  final String msg;
  final List<DetailsOrder> detailsOrder;

  OrderDetailsResponse({
    required this.resp,
    required this.msg,
    required this.detailsOrder,
  });    

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => OrderDetailsResponse(
    resp: json["resp"],
    msg: json["msg"],
    detailsOrder: json["detailsOrder"] != null ? List<DetailsOrder>.from(json["detailsOrder"].map((x) => DetailsOrder.fromJson(x))) : [],
  );
}

class DetailsOrder {

  final int id;
  final int orderId;
  final int productId;
  final String nameProduct;
  final String picture;
  final int quantity;
  final double total;

  DetailsOrder({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.nameProduct,
    required this.picture,
    required this.quantity,
    required this.total,
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

}
