class TicksRequest {
  TicksRequest({
    required this.ticks,
    required this.subscribe,
  });

  final String? ticks;
  final int? subscribe;

  factory TicksRequest.fromJson(Map<String, dynamic> json) {
    return TicksRequest(
      ticks: json["ticks"],
      subscribe: json["subscribe"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ticks": ticks,
        "subscribe": subscribe,
      };
}
