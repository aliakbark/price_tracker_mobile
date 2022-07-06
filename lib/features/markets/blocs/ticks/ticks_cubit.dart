import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker_mobile/features/markets/blocs/markets/markets_cubit.dart';
import 'package:price_tracker_mobile/features/markets/data/ticks_repository.dart';
import 'package:price_tracker_mobile/features/markets/models/active_symbols_response.dart';
import 'package:price_tracker_mobile/features/markets/models/ticks_request.dart';
import 'package:price_tracker_mobile/features/markets/models/ticks_response.dart';
import 'package:price_tracker_mobile/features/markets/models/forget_request.dart';

part 'ticks_state.dart';

///Ticks cubit class
class TicksCubit extends Cubit<TicksState> {
  final TicksRepository _ticksRepository;

  String? _ticksSubscriptionId;

  Tick? _lastTick;

  /// TicksCubit initializer
  TicksCubit(this._ticksRepository, MarketsCubit marketsCubit)
      : super(const TicksInitial()) {
    ///Listen to the selection a symbol
    marketsCubit.stream.listen((MarketsState marketsState) async {
      if (marketsState is MarketsLoaded) {
        if (marketsState.selectedSymbol != null) {
          subscribeTicks(selectedSymbol: marketsState.selectedSymbol);
        }
      }
    });
  }

  /// Subscribe ticks to see selected symbol's price and their movements
  Future<void> subscribeTicks({required ActiveSymbol? selectedSymbol}) async {
    try {
      emit(const TicksLoading());
      _ticksRepository
          .subscribeTicks(
              ticksRequest:
                  TicksRequest(ticks: selectedSymbol!.symbol, subscribe: 1))
          .listen((TicksResponse event) {
        _ticksSubscriptionId = event.subscription?.id;
        emit(TicksLoaded(tick: event.tick, previousTick: _lastTick));
        _lastTick = event.tick;
      }, onError: (error) {
        emit(TicksError(error.toString()));
      });
    } catch (e) {
      emit(TicksError(e.toString()));
    }
  }

  ///Unsubscribe stream data
  Future<void> unSubscribeTicks({required String subscriptionId}) async {
    _ticksRepository.unSubscribeTicks(
        forgetRequest: ForgetRequest(forget: subscriptionId));
  }

  @override
  Future<void> close() async {
    if (_ticksSubscriptionId != null) {
      await unSubscribeTicks(subscriptionId: _ticksSubscriptionId!);
    }
    super.close();
  }
}
