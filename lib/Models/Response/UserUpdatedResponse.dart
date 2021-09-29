import 'dart:convert';

UserUpdatedResponse userUpdatedResponseFromJson(String str) => UserUpdatedResponse.fromJson(json.decode(str));

String userUpdatedResponseToJson(UserUpdatedResponse data) => json.encode(data.toJson());

class UserUpdatedResponse {

    bool resp;
    String msg;
    UserUpdated user;

    UserUpdatedResponse({
        required this.resp,
        required this.msg,
        required this.user,
    });

    factory UserUpdatedResponse.fromJson(Map<String, dynamic> json) => UserUpdatedResponse(
        resp: json["resp"],
        msg: json["msg"],
        user: UserUpdated.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "user": user.toJson(),
    };
}

class UserUpdated {

    String firstName;
    String lastName;
    String image;
    String email;
    int rolId;
    String? address;
    String? reference;

    UserUpdated({
        required this.firstName,
        required this.lastName,
        required this.image,
        required this.email,
        required this.rolId,
        this.address,
        this.reference
    });

    

    factory UserUpdated.fromJson(Map<String, dynamic> json) => UserUpdated(
        firstName: json["firstName"],
        lastName: json["lastName"],
        image: json["image"],
        email: json["email"],
        rolId: json["rol_id"],
        address: json["address"],
        reference: json["reference"]
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "image": image,
        "email": email,
        "rol_id": rolId,
        "address" : address,
        "reference": reference
    };
}
