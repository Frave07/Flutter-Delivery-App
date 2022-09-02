
class ProductsTopHomeResponse {

  final bool resp;
  final String msg;
  final List<Productsdb> productsdb;

  ProductsTopHomeResponse({
    required this.resp,
    required this.msg,
    required this.productsdb,
  });

  factory ProductsTopHomeResponse.fromJson(Map<String, dynamic> json) => ProductsTopHomeResponse(
    resp: json["resp"],
    msg: json["msg"],
    productsdb: json["productsdb"] != null ? List<Productsdb>.from(json["productsdb"].map((x) => Productsdb.fromJson(x))).toList() : [],
  );
}

class Productsdb {

  final int id;
  final String nameProduct;
  final String description;
  final double price;
  final int status;
  final String picture;
  final String category;
  final int categoryId;

  Productsdb({
    required this.id,
    required this.nameProduct,
    required this.description,
    required this.price,
    required this.status,
    required this.picture,
    required this.category,
    required this.categoryId
  });

  factory Productsdb.fromJson(Map<String, dynamic> json) => Productsdb(
    id: json["id"],
    nameProduct: json["nameProduct"],
    description: json["description"],
    price: json["price"].toDouble(),
    status: json["status"],
    picture: json["picture"],
    category: json["category"],
    categoryId: json["category_id"]
  );
}
