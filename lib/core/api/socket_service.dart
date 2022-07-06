import 'package:web_socket_channel/io.dart';

abstract class BaseSocketService {
  /// Connects to Socket.
  IOWebSocketChannel? connect({required String baseURL, required String appId});

  IOWebSocketChannel? get channel;

  void reset();
}

/// This class is for handling connection and calling APIs.
class SocketService extends BaseSocketService {
  /// Represents the active web socket connection.
  IOWebSocketChannel? _channel;

  static const String baseURL = "wss://ws.binaryws.com/websockets/v3";
  static const String appId = "32317";

  /// Initializes socket connection.
  SocketService() {
    connect(baseURL: baseURL, appId: appId);
  }


  ///Getter method for accessing socket channel
  @override
  IOWebSocketChannel? get channel {
    return _channel ??= connect(baseURL: baseURL, appId: appId);
  }

  ///Reset socket channel
  @override
  reset() {
    if (_channel != null) {
      _channel!.sink.close();
    }
  }

  ///Establish socket connection with api URL and app id.
  @override
  IOWebSocketChannel? connect(
      {required String baseURL, required String appId}) {
    final Uri uri = Uri(
      scheme: 'wss',
      host: "ws.binaryws.com",
      path: '/websockets/v3',
      queryParameters: <String, dynamic>{
        'app_id': appId,
      },
    );
    _channel ??= IOWebSocketChannel.connect(uri.toString());
    return _channel;
  }
}
