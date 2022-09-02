
class ResponseDefault {

  final bool resp;
  final String msg;

  ResponseDefault({
    required this.resp,
    required this.msg,
  });

  factory ResponseDefault.fromJson(Map<String, dynamic> json) => ResponseDefault(
    resp: json["resp"],
    msg: json["msg"],
  );

}
