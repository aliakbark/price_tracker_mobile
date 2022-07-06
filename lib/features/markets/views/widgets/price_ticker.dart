import 'package:flutter/material.dart';
import 'package:price_tracker_mobile/features/markets/models/ticks_response.dart';

class PriceTicker extends StatefulWidget {
  final Tick? tick;
  final Tick? previousTick;

  const PriceTicker({Key? key, this.tick, this.previousTick}) : super(key: key);

  @override
  State<PriceTicker> createState() => _PriceTickerState();
}

class _PriceTickerState extends State<PriceTicker> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_getQuote(tick: widget.tick)}',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: _quoteDiff(
                                  tick: widget.tick,
                                  previousTick: widget.previousTick)
                              .isNegative
                          ? Colors.red
                          : Colors.green),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "${_quoteDiffInPercentage(tick: widget.tick, previousTick: widget.previousTick).toStringAsFixed(3)}%",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          _quoteDiff(tick: widget.tick, previousTick: widget.previousTick)
                  .isNegative
              ? const Icon(
                  Icons.arrow_downward,
                  size: 40.0,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.arrow_upward,
                  size: 40.0,
                  color: Colors.green,
                ),
        ],
      ),
    );
  }

  String? _getQuote({Tick? tick}) {
    if (tick != null) {
      return tick.quote.toString();
    }
    return "00.00";
  }

  double _quoteDiffInPercentage({Tick? tick, Tick? previousTick}) {
    try {
      if (tick != null && previousTick != null) {
        double percentageDiff = 0.0;
        percentageDiff =
            ((tick.quote! - previousTick.quote!) * 100) / previousTick.quote!;
        return percentageDiff;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  double _quoteDiff({Tick? tick, Tick? previousTick}) {
    try {
      if (tick != null && previousTick != null) {
        double difference = 0.0;
        difference = (tick.quote! - previousTick.quote!);
        return difference;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }
}
