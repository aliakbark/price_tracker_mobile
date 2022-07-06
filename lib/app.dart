import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker_mobile/features/markets/blocs/markets/markets_cubit.dart';
import 'package:price_tracker_mobile/features/markets/data/markets_repository.dart';
import 'package:price_tracker_mobile/features/markets/views/screens/markets_home.dart';

//Main App
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    ///Create and inject Market's cubit class instance
    return MultiBlocProvider(
      providers: [
        BlocProvider<MarketsCubit>(
          create: (BuildContext context) => MarketsCubit(MarketsRepository()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MarketsHome(),

        ///Market watch widget
      ),
    );
  }
}
