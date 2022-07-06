import 'package:price_tracker_mobile/features/markets/models/active_symbols_response.dart';
import 'package:quiver/collection.dart';

///Helper class which serves utility helper function
class Helper {
  ///Remove repetitive market items from active symbol's whole list
  static List<ActiveSymbol> removeMarketDuplicates(
      List<ActiveSymbol> marketsList) {
    Set<ActiveSymbol> marketsSet =
        TreeSet<ActiveSymbol>(comparator: (ActiveSymbol a, ActiveSymbol b) {
      if (a.market?.toLowerCase().trim() == b.market?.toLowerCase().trim()) {
        return 0;
      } else {
        return 1;
      }
    });
    marketsSet.addAll(marketsList);

    return marketsSet.toList();
  }
}
