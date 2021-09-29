import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) => ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {

    bool resp;
    String msg;
    User? user;
    String? token;

    ResponseLogin({
        required this.resp,
        required this.msg,
        this.user,
        this.token,
    });

    factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        resp: json["resp"],
        msg: json["msg"],
        user: User.fromJson(json["user"] != null ? json["user"] : Map()),
        token: json["token"] != null ? json["token"] : '',
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "user": user!.toJson(),
        "token": token,
    };
}

class User {
    
    int? uid;
    String? firstName;
    String? lastName;
    String? image;
    String? email;
    String? phone;
    int? rolId;
    String? notificationToken;

    User({
        this.uid,
        this.firstName,
        this.lastName,
        this.phone,
        this.image,
        this.email,
        this.rolId,
        this.notificationToken
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"] != null ? json["uid"] : 0,
        firstName: json["firstName"] != null ? json["firstName"] : '',
        lastName: json["lastName"] != null ? json["lastName"] : '',
        phone: json["phone"] != null ? json["phone"] : '',
        image: json["image"] != null ? json["image"] : '',
        email: json["email"] != null ? json["email"] : '',
        rolId: json["rol_id"] != null ? json["rol_id"] : 0,
        notificationToken: json["notification_token"] != null ? json["notification_token"] : ''
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "phone" : phone,
        "image": image,
        "email": email,
        "rol_id": rolId,
        "notification_token" : notificationToken
    };
}
