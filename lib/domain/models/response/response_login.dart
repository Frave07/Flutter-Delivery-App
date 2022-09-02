
class ResponseLogin {

  final bool resp;
  final String msg;
  final User user;
  final String token;

  ResponseLogin({
    required this.resp,
    required this.msg,
    required this.token,
    required this.user,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
    resp: json["resp"],
    msg: json["msg"],
    user: User.fromJson(json["user"] ?? {}),
    token: json["token"] ?? '',
  );

}

class User {
    
  final int uid;
  final String firstName;
  final String lastName;
  final String image;
  final String email;
  final String phone;
  final int rolId;
  final String notificationToken;

  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
    required this.email,
    required this.rolId,
    required this.notificationToken
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json["uid"] ?? 0,
    firstName: json["firstName"] ?? '',
    lastName: json["lastName"] ?? '',
    phone: json["phone"] ?? '',
    image: json["image"] ?? '',
    email: json["email"] ?? '',
    rolId: json["rol_id"] ?? 0,
    notificationToken: json["notification_token"] ?? ''
  );

}
