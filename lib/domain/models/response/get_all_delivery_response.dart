
class GetAllDeliveryResponse {
    
  final bool resp;
  final String msg;
  final List<Delivery> delivery;

  GetAllDeliveryResponse({
    required this.resp,
    required this.msg,
    required this.delivery,
  });

  factory GetAllDeliveryResponse.fromJson(Map<String, dynamic> json) => GetAllDeliveryResponse(
    resp: json["resp"],
    msg: json["msg"],
    delivery: json["delivery"] != null ? List<Delivery>.from(json["delivery"].map((x) => Delivery.fromJson(x))) : [],
  );

}

class Delivery {

  final int personId;
  final String nameDelivery;
  final String phone;
  final String image;
  final String notificationToken;

  Delivery({
    required this.personId,
    required this.nameDelivery,
    required this.phone,
    required this.image,
    required this.notificationToken
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    personId: json["person_id"],
    nameDelivery: json["nameDelivery"],
    phone: json["phone"],
    image: json["image"],
    notificationToken: json["notification_token"]
  );
}
