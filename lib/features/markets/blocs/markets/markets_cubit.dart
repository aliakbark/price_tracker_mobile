import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker_mobile/core/helper.dart';
import 'package:price_tracker_mobile/features/markets/data/markets_repository.dart';
import 'package:price_tracker_mobile/features/markets/models/active_symbols_request.dart';
import 'package:price_tracker_mobile/features/markets/models/active_symbols_response.dart';

part 'markets_state.dart';

///Markets cubit class
class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit(this._marketsRepository) : super(const MarketsInitial());

  final MarketsRepository _marketsRepository;

  ///Fetch active symbols
  Future<void> getMarkets() async {
    try {
      emit(const MarketsLoading());
      _marketsRepository
          .fetchActiveSymbols(
              activeSymbolsRequest: ActiveSymbolsRequest(
                  activeSymbols: "brief", productType: "basic"))
          .listen((ActiveSymbolsResponse event) {
        emit(MarketsLoaded(marketsList: event.activeSymbols));
      }, onError: (error) {
        emit(MarketsError(error.toString()));
      });
    } catch (e) {
      emit(MarketsError(e.toString()));
    }
  }

  ///Select market from the list
  Future<void> selectMarket(
      {required MarketsLoaded loadedState,
      required ActiveSymbol? selectedMarket}) async {
    emit(MarketsLoaded(
      marketsList: loadedState.marketsList,
      selectedMarket: selectedMarket,
    ));
  }

  ///Select Symbol from the list loaded according to market selection
  Future<void> selectSymbol(
      {required MarketsLoaded loadedState,
      required ActiveSymbol? selectedSymbol}) async {
    emit(MarketsLoaded(
        marketsList: loadedState.marketsList,
        selectedMarket: loadedState.selectedMarket,
        selectedSymbol: selectedSymbol));
  }
}
