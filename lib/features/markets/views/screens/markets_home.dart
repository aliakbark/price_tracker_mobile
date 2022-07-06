import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker_mobile/core/resources/resources.dart';
import 'package:price_tracker_mobile/features/markets/blocs/markets/markets_cubit.dart';
import 'package:price_tracker_mobile/features/markets/blocs/ticks/ticks_cubit.dart';
import 'package:price_tracker_mobile/features/markets/data/ticks_repository.dart';
import 'package:price_tracker_mobile/features/markets/models/active_symbols_response.dart';
import 'package:price_tracker_mobile/features/markets/views/widgets/custom_dropdown.dart';
import 'package:price_tracker_mobile/features/markets/views/widgets/price_ticker.dart';

class MarketsHome extends StatefulWidget {
  const MarketsHome({Key? key}) : super(key: key);

  @override
  State<MarketsHome> createState() => _MarketsHomeState();
}

class _MarketsHomeState extends State<MarketsHome> {
  MarketsCubit? _marketsCubit;
  TicksCubit? _ticksCubit;

  @override
  void initState() {
    super.initState();

    _marketsCubit = BlocProvider.of<MarketsCubit>(context);
    _marketsCubit?.getMarkets();
    _ticksCubit = TicksCubit(TicksRepository(), _marketsCubit!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                children: [
                  const Image(
                      image: AssetImage(Images.derivLogo), height: 24.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Deriv',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontStyle: FontStyle.italic)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocConsumer<MarketsCubit, MarketsState>(
                      listener:
                          (BuildContext context, MarketsState marketsState) {
                        if (marketsState is MarketsError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(marketsState.message),
                            ),
                          );
                        }
                      },
                      builder:
                          (BuildContext context, MarketsState marketsState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _getMarketWidget(
                              marketsState: marketsState,
                            ),
                            _getSymbolWidget(marketsState: marketsState),
                          ],
                        );
                      },
                    ),
                    ///Price ticker widget
                    Expanded(
                      child: BlocBuilder<TicksCubit, TicksState>(
                        bloc: _ticksCubit,
                        builder: (BuildContext context, TicksState ticksState) {
                          if (ticksState is TicksLoaded) {
                            return PriceTicker(
                                tick: ticksState.tick,
                                previousTick: ticksState.previousTick);
                          } else {
                            return const PriceTicker();
                            return const Text("No tick data");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Market list dropdown widget
  Widget _getMarketWidget({MarketsState? marketsState}) {
    if (marketsState is MarketsLoaded) {
      return CustomDropdown(
        key: UniqueKey(),
        title: "Market",
        hint: const Text("Select market"),
        value: marketsState.selectedMarket,
        items: marketsState.marketsList.map((ActiveSymbol item) {
          return DropdownMenuItem(
            value: item,
            child: Text("${item.marketDisplayName}(${item.market})"),
          );
        }).toList(),
        onChanged: (newValue) {
          _marketsCubit?.selectMarket(
              loadedState: marketsState, selectedMarket: newValue);
        },
      );
    }

    ///For loading and as a place holder
    return CustomDropdown(
      key: UniqueKey(),
      title: "Market",
      hint: const Text("Select market"),
      isLoading: true,
      value: null,
      items: const [],
      onChanged: null,
    );
  }

  ///Symbol list dropdown widget
  Widget _getSymbolWidget({MarketsState? marketsState}) {
    if (marketsState is MarketsLoaded) {
      return CustomDropdown(
        key: UniqueKey(),
        title: "Symbol",
        hint: const Text("Select symbol"),
        value: marketsState.selectedSymbol,
        items: marketsState.symbolsList.map((ActiveSymbol item) {
          return DropdownMenuItem(
            value: item,
            child: Text("${item.displayName}"),
          );
        }).toList(),
        onChanged: (newValue) {
          _marketsCubit?.selectSymbol(
              loadedState: marketsState, selectedSymbol: newValue);
        },
      );
    }

    ///For loading and as a place holder
    return CustomDropdown(
      key: UniqueKey(),
      title: "Symbol",
      hint: const Text("Select symbol"),
      isLoading: true,
      value: null,
      items: const [],
      onChanged: null,
    );
  }
}
