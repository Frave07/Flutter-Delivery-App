
class ImagesProductsResponse {
    
  final bool resp;
  final String msg;
  final List<ImageProductdb> imageProductdb;

  ImagesProductsResponse({
    required this.resp,
    required this.msg,
    required this.imageProductdb,
  });

  factory ImagesProductsResponse.fromJson(Map<String, dynamic> json) => ImagesProductsResponse(
    resp: json["resp"],
    msg: json["msg"],
    imageProductdb: json["imageProductdb"] != null ? List<ImageProductdb>.from(json["imageProductdb"].map((x) => ImageProductdb.fromJson(x))) : [],
  );
}

class ImageProductdb {

  final int id;
  final String picture;
  final int productId;

  ImageProductdb({
    required this.id,
    required this.picture,
    required this.productId,
  });

  factory ImageProductdb.fromJson(Map<String, dynamic> json) => ImageProductdb(
    id: json["id"],
    picture: json["picture"],
    productId: json["product_id"],
  );
}
