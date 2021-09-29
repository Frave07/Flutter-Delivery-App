import 'dart:convert';

AddressOneResponse addressOneResponseFromJson(String str) => AddressOneResponse.fromJson(json.decode(str));

String addressOneResponseToJson(AddressOneResponse data) => json.encode(data.toJson());

class AddressOneResponse {
    
    bool resp;
    String msg;
    Address? address;

    AddressOneResponse({
        required this.resp,
        required this.msg,
        this.address,
    });

    factory AddressOneResponse.fromJson(Map<String, dynamic> json) => AddressOneResponse(
        resp: json["resp"],
        msg: json["msg"],
        address: Address.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "address": address!.toJson(),
    };
}

class Address {

    int id;
    String street;
    String reference;
    String latitude;
    String longitude;
    int personaId;

    Address({
        required this.id,
        required this.street,
        required this.reference,
        required this.latitude,
        required this.longitude,
        required this.personaId,
    });

    

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        street: json["street"],
        reference: json["reference"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        personaId: json["persona_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "reference": reference,
        "Latitude": latitude,
        "Longitude": longitude,
        "persona_id": personaId,
    };
}
