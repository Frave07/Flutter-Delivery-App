
class AddressOneResponse {
    
  final bool resp;
  final String msg;
  final Address address;

  AddressOneResponse({
    required this.resp,
    required this.msg,
    required this.address,
  });

  factory AddressOneResponse.fromJson(Map<String, dynamic> json) => AddressOneResponse(
    resp: json["resp"],
    msg: json["msg"],
    address: Address.fromJson(json["address"] ?? {}),
  );
}

class Address {

  final int id;
  final String street;
  final String reference;
  final String latitude;
  final String longitude;
  final int personaId;

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
}
