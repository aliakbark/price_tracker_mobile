import 'package:equatable/equatable.dart';

class TicksResponse extends Equatable {
  TicksResponse({
    required this.echoReq,
    required this.msgType,
    required this.subscription,
    required this.tick,
  });

  final EchoReq? echoReq;
  final String? msgType;
  final Subscription? subscription;
  final Tick? tick;

  factory TicksResponse.fromJson(Map<String, dynamic> json) {
    return TicksResponse(
      echoReq:
          json["echo_req"] == null ? null : EchoReq.fromJson(json["echo_req"]),
      msgType: json["msg_type"],
      subscription: json["subscription"] == null
          ? null
          : Subscription.fromJson(json["subscription"]),
      tick: json["tick"] == null ? null : Tick.fromJson(json["tick"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "echo_req": echoReq?.toJson(),
        "msg_type": msgType,
        "subscription": subscription?.toJson(),
        "tick": tick?.toJson(),
      };

  @override
  List<Object?> get props => [tick?.quote];
}

class EchoReq {
  EchoReq({
    required this.subscribe,
    required this.ticks,
  });

  final int? subscribe;
  final String? ticks;

  factory EchoReq.fromJson(Map<String, dynamic> json) {
    return EchoReq(
      subscribe: json["subscribe"],
      ticks: json["ticks"],
    );
  }

  Map<String, dynamic> toJson() => {
        "subscribe": subscribe,
        "ticks": ticks,
      };
}

class Subscription {
  Subscription({
    required this.id,
  });

  final String? id;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Tick extends Equatable {
  Tick({
    required this.ask,
    required this.bid,
    required this.epoch,
    required this.id,
    required this.pipSize,
    required this.quote,
    required this.symbol,
  });

  final double? ask;
  final double? bid;
  final int? epoch;
  final String? id;
  final int? pipSize;
  final double? quote;
  final String? symbol;

  factory Tick.fromJson(Map<String, dynamic> json) {
    return Tick(
      ask: json["ask"],
      bid: json["bid"],
      epoch: json["epoch"],
      id: json["id"],
      pipSize: json["pip_size"],
      quote: json["quote"],
      symbol: json["symbol"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ask": ask,
        "bid": bid,
        "epoch": epoch,
        "id": id,
        "pip_size": pipSize,
        "quote": quote,
        "symbol": symbol,
      };

  @override
  List<Object?> get props => [symbol, quote, ask, bid];
}
