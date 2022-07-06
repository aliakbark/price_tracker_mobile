class ForgetResponse {
  ForgetResponse({
    required this.echoReq,
    required this.forget,
    required this.msgType,
  });

  final EchoReq? echoReq;
  final int? forget;
  final String? msgType;

  factory ForgetResponse.fromJson(Map<String, dynamic> json) {
    return ForgetResponse(
      echoReq:
          json["echo_req"] == null ? null : EchoReq.fromJson(json["echo_req"]),
      forget: json["forget"],
      msgType: json["msg_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "echo_req": echoReq?.toJson(),
        "forget": forget,
        "msg_type": msgType,
      };
}

class EchoReq {
  EchoReq({
    required this.forget,
  });

  final String? forget;

  factory EchoReq.fromJson(Map<String, dynamic> json) {
    return EchoReq(
      forget: json["forget"],
    );
  }

  Map<String, dynamic> toJson() => {
        "forget": forget,
      };
}
