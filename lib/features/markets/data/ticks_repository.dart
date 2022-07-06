import 'dart:convert';

import 'package:price_tracker_mobile/core/api/socket_service.dart';
import 'package:price_tracker_mobile/features/markets/models/forget_request.dart';
import 'package:price_tracker_mobile/features/markets/models/forget_response.dart';
import 'package:price_tracker_mobile/features/markets/models/ticks_request.dart';
import 'package:price_tracker_mobile/features/markets/models/ticks_response.dart';

// Ticks Repository is a layer class between network and data which handles data to bloc class
abstract class BaseTicksRepository {
  Stream<TicksResponse> subscribeTicks({required TicksRequest? ticksRequest});

  Stream<ForgetResponse> unSubscribeTicks(
      {required ForgetRequest forgetRequest});
}

class TicksRepository implements BaseTicksRepository {
  final _socket = SocketService();

  ///Subscribe price tick data based on the selected market and symbol.
  @override
  Stream<TicksResponse> subscribeTicks({required TicksRequest? ticksRequest}) {
    _socket.channel!.sink.add(jsonEncode(ticksRequest));
    return _socket.channel!.stream.map<TicksResponse>(
        (value) => TicksResponse.fromJson(jsonDecode(value)));
  }

  @override
  Stream<ForgetResponse> unSubscribeTicks(
      {required ForgetRequest forgetRequest}) {
    // _ioWebSocketChannel.sink.add(jsonEncode(forgetRequest));
    // return _ioWebSocketChannel.stream.map<ForgetResponse>(
    //     (value) => ForgetResponse.fromJson(jsonDecode(value)));
    _socket.channel!.sink.add(jsonEncode(forgetRequest));
    return _socket.channel!.stream.map<ForgetResponse>(
        (value) => ForgetResponse.fromJson(jsonDecode(value)));
  }
}
