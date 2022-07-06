import 'package:equatable/equatable.dart';

class ActiveSymbolsResponse {
  ActiveSymbolsResponse({
    required this.activeSymbols,
    required this.echoReq,
    required this.msgType,
  });

  final List<ActiveSymbol> activeSymbols;
  final EchoReq? echoReq;
  final String? msgType;

  factory ActiveSymbolsResponse.fromJson(Map<String, dynamic> json) {
    return ActiveSymbolsResponse(
      activeSymbols: json["active_symbols"] == null
          ? []
          : List<ActiveSymbol>.from(
              json["active_symbols"]!.map((x) => ActiveSymbol.fromJson(x))),
      echoReq:
          json["echo_req"] == null ? null : EchoReq.fromJson(json["echo_req"]),
      msgType: json["msg_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "active_symbols":
            List<ActiveSymbol>.from(activeSymbols.map((x) => x.toJson())),
        "echo_req": echoReq?.toJson(),
        "msg_type": msgType,
      };
}

class ActiveSymbol extends Equatable {
  const ActiveSymbol({
    required this.allowForwardStarting,
    required this.displayName,
    required this.exchangeIsOpen,
    required this.isTradingSuspended,
    required this.market,
    required this.marketDisplayName,
    required this.pip,
    required this.submarket,
    required this.submarketDisplayName,
    required this.symbol,
    required this.symbolType,
  });

  final int? allowForwardStarting;
  final String? displayName;
  final int? exchangeIsOpen;
  final int? isTradingSuspended;
  final String? market;
  final String? marketDisplayName;
  final double? pip;
  final String? submarket;
  final String? submarketDisplayName;
  final String? symbol;
  final String? symbolType;

  factory ActiveSymbol.fromJson(Map<String, dynamic> json) {
    return ActiveSymbol(
      allowForwardStarting: json["allow_forward_starting"],
      displayName: json["display_name"],
      exchangeIsOpen: json["exchange_is_open"],
      isTradingSuspended: json["is_trading_suspended"],
      market: json["market"],
      marketDisplayName: json["market_display_name"],
      pip: json["pip"],
      submarket: json["submarket"],
      submarketDisplayName: json["submarket_display_name"],
      symbol: json["symbol"],
      symbolType: json["symbol_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "allow_forward_starting": allowForwardStarting,
        "display_name": displayName,
        "exchange_is_open": exchangeIsOpen,
        "is_trading_suspended": isTradingSuspended,
        "market": market,
        "market_display_name": marketDisplayName,
        "pip": pip,
        "submarket": submarket,
        "submarket_display_name": submarketDisplayName,
        "symbol": symbol,
        "symbol_type": symbolType,
      };

  @override
  List<Object?> get props => [market, symbol];
}

class EchoReq {
  EchoReq({
    required this.activeSymbols,
    required this.productType,
  });

  final String? activeSymbols;
  final String? productType;

  factory EchoReq.fromJson(Map<String, dynamic> json) {
    return EchoReq(
      activeSymbols: json["active_symbols"],
      productType: json["product_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "active_symbols": activeSymbols,
        "product_type": productType,
      };
}
