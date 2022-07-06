import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:price_tracker_mobile/app.dart';
import 'package:price_tracker_mobile/core/api/socket_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(const App());
  }, (error, stack) {
    if (kDebugMode) print(error);
  });
}
