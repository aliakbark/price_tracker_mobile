part of 'markets_cubit.dart';

abstract class MarketsState extends Equatable {
  const MarketsState();
}

class MarketsInitial extends MarketsState {
  const MarketsInitial();

  @override
  List<Object> get props => [];
}

class MarketsLoading extends MarketsState {
  const MarketsLoading();

  @override
  List<Object> get props => [];
}

class MarketsLoaded extends MarketsState {
  /// Initializes
  MarketsLoaded({
    required List<ActiveSymbol> marketsList,
    ActiveSymbol? selectedMarket,
    ActiveSymbol? selectedSymbol,
  })  : _marketsList = marketsList,
        _selectedMarket = selectedMarket ??
            (marketsList.isNotEmpty ? marketsList.first : null),
        _selectedSymbol = selectedSymbol;

  /// List of markets
  final List<ActiveSymbol> _marketsList;

  final ActiveSymbol? _selectedMarket;

  final ActiveSymbol? _selectedSymbol;

  /// Markets list
  List<ActiveSymbol> get marketsList =>
      Helper.removeMarketDuplicates(_marketsList);

  /// Markets list
  List<ActiveSymbol> get symbolsList => _marketsList
      .where((element) => element.market == selectedMarket?.market)
      .toList();

  /// Selected market
  ActiveSymbol? get selectedMarket => _selectedMarket;

  /// Selected symbol
  ActiveSymbol? get selectedSymbol => _selectedSymbol;

  @override
  List<Object?> get props => [marketsList, _selectedMarket, selectedSymbol];
}

class MarketsError extends MarketsState {
  const MarketsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
