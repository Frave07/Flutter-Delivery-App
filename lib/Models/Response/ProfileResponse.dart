import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {

    bool resp;
    String msg;
    UserResponse user;

    ProfileResponse({
        required this.resp,
        required this.msg,
        required this.user,
    });

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        resp: json["resp"],
        msg: json["msg"],
        user: UserResponse.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "user": user.toJson(),
    };
}

class UserResponse {

    String uid;
    String firstName;
    String lastName;
    String phone;
    String image;
    String email;
    String notificationToken;

    UserResponse({
        required this.uid,
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.image,
        required this.email,
        required this.notificationToken
    });

    

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        uid: json["uid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        image: json["image"],
        email: json["email"],
        notificationToken: json["notification_token"]
    );

    Map<String, dynamic> toJson() => {
        "uid" : uid,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "image": image,
        "email": email,
        "notification_token" : notificationToken
    };
}
