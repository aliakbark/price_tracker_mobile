class ForgetRequest {
  ForgetRequest({
    required this.forget,
  });

  final String forget;

  factory ForgetRequest.fromJson(Map<String, dynamic> json) {
    return ForgetRequest(
      forget: json["forget"],
    );
  }

  Map<String, dynamic> toJson() => {
        "forget": forget,
      };
}
