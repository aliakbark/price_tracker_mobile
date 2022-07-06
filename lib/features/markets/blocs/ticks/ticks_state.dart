part of 'ticks_cubit.dart';

abstract class TicksState extends Equatable {
  const TicksState();
}

class TicksInitial extends TicksState {
  const TicksInitial();

  @override
  List<Object> get props => [];
}

class TicksLoading extends TicksState {
  const TicksLoading();

  @override
  List<Object> get props => [];
}

class TicksLoaded extends TicksState {
  final Tick? _tick;
  final Tick? _previousTick;

  ///Initialize
  const TicksLoaded({
    required Tick? tick,
    Tick? previousTick,
  })  : _tick = tick,
        _previousTick = previousTick;

  Tick? get tick => _tick;

  Tick? get previousTick => _previousTick;

  @override
  List<Object?> get props => [_tick, _previousTick];
}


class TicksError extends TicksState {
  const TicksError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
