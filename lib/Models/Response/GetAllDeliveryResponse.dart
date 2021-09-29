import 'dart:convert';

GetAllDeliveryResponse getAllDeliveryResponseFromJson(String str) => GetAllDeliveryResponse.fromJson(json.decode(str));

String getAllDeliveryResponseToJson(GetAllDeliveryResponse data) => json.encode(data.toJson());

class GetAllDeliveryResponse {
    
    bool? resp;
    String? msg;
    List<Delivery>? delivery;

    GetAllDeliveryResponse({
        this.resp,
        this.msg,
        this.delivery,
    });

    factory GetAllDeliveryResponse.fromJson(Map<String, dynamic> json) => GetAllDeliveryResponse(
        resp: json["resp"],
        msg: json["msg"],
        delivery: List<Delivery>.from(json["delivery"].map((x) => Delivery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "delivery": List<dynamic>.from(delivery!.map((x) => x.toJson())),
    };
}

class Delivery {

    int? personId;
    String? nameDelivery;
    String? phone;
    String? image;
    String? notificationToken;

    Delivery({
        this.personId,
        this.nameDelivery,
        this.phone,
        this.image,
        this.notificationToken
    });

    
    factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        personId: json["person_id"],
        nameDelivery: json["nameDelivery"],
        phone: json["phone"],
        image: json["image"],
        notificationToken: json["notification_token"]
    );

    Map<String, dynamic> toJson() => {
        "person_id": personId,
        "nameDelivery": nameDelivery,
        "phone": phone,
        "image": image,
        "notification_token" : notificationToken
    };
}
