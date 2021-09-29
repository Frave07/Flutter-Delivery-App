import 'dart:convert';

ImagesProductsResponse imagesProductsResponseFromJson(String str) => ImagesProductsResponse.fromJson(json.decode(str));

String imagesProductsResponseToJson(ImagesProductsResponse data) => json.encode(data.toJson());

class ImagesProductsResponse {
    
    bool resp;
    String msg;
    List<ImageProductdb> imageProductdb;

    ImagesProductsResponse({
        required this.resp,
        required this.msg,
        required this.imageProductdb,
    });

    factory ImagesProductsResponse.fromJson(Map<String, dynamic> json) => ImagesProductsResponse(
        resp: json["resp"],
        msg: json["msg"],
        imageProductdb: List<ImageProductdb>.from(json["imageProductdb"].map((x) => ImageProductdb.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "imageProductdb": List<dynamic>.from(imageProductdb.map((x) => x.toJson())),
    };
}

class ImageProductdb {

    int id;
    String picture;
    int productId;

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

    Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "product_id": productId,
    };
}
