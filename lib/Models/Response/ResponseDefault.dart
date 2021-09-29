import 'dart:convert';

ResponseDefault responseDefaultFromJson(String str) => ResponseDefault.fromJson(json.decode(str));

String responseDefaultToJson(ResponseDefault data) => json.encode(data.toJson());

class ResponseDefault {

    bool resp;
    String msg;

    ResponseDefault({
        required this.resp,
        required this.msg,
    });

    factory ResponseDefault.fromJson(Map<String, dynamic> json) => ResponseDefault(
        resp: json["resp"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
    };
}
