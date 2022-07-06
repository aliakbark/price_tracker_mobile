class ActiveSymbolsRequest {
  ActiveSymbolsRequest({
    required this.activeSymbols,
    required this.productType,
  });

  final String? activeSymbols;
  final String? productType;

  factory ActiveSymbolsRequest.fromJson(Map<String, dynamic> json) {
    return ActiveSymbolsRequest(
      activeSymbols: json["active_symbols"],
      productType: json["product_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "active_symbols": activeSymbols,
        "product_type": productType,
      };
}
