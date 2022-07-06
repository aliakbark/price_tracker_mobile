import 'dart:convert';

import 'package:price_tracker_mobile/core/api/socket_service.dart';
import 'package:price_tracker_mobile/features/markets/models/active_symbols_request.dart';
import 'package:price_tracker_mobile/features/markets/models/active_symbols_response.dart';

/// Market Repository is a layer class between network and data which handles data to bloc class
abstract class BaseMarketsRepository {
  Stream<ActiveSymbolsResponse> fetchActiveSymbols(
      {required ActiveSymbolsRequest? activeSymbolsRequest});
}

class MarketsRepository implements BaseMarketsRepository {
  final _socket = SocketService();

  /// Fetch list of active symbols
  @override
  Stream<ActiveSymbolsResponse> fetchActiveSymbols(
      {required ActiveSymbolsRequest? activeSymbolsRequest}) {
    _socket.channel!.sink.add(jsonEncode(activeSymbolsRequest));
    return _socket.channel!.stream.map<ActiveSymbolsResponse>(
            (value) => ActiveSymbolsResponse.fromJson(jsonDecode(value)));
  }
}
