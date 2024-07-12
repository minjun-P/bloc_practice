import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../ticker.dart';

part 'timer_event.dart';

part 'timer_state.dart';

// Bloc 정석에서는 항상 Event와 State로 Wrapping된 것을 사용 -> SealedClass를 사용 추천
class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  // 초기 State가 정의되어 있어야 한다.
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    // 각 Event에 대한 핸들러 정의
    // 헷갈리면 안된다. Bloc이란 결국, 모든 케이스의 이벤트에 대하여 State를 어떻게 다룰 것인지에 대해
    // 정의하는 것이다. 이를 선언적으로 정의하여 event를 넣었을 때 알아서 잘 작동하는 일종의 자동기계를
    // 만드는 것임.
    on<TimerStarted>(_onTimerStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<_TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() async {
    _tickerSubscription?.cancel();
    super.close();
  }

  // StartedEvent에 대한 핸들러 정의
  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    // 바로 state를 변경 때린다. 진행중 상태로 변경
    emit(TimerRunInProgress(event.duration));

    // ticker subscription을 새롭게 초기화 - 기존꺼 제거
    _tickerSubscription?.cancel();

    // ticker의 매 초마다 event를 호출하도록 subscription setting
    // 호출하는 event는 ticked로, tick이 일어나고 있다는 event
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((durationFromTicker) => add(_TimerTicked(duration: durationFromTicker)));
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    final isDone = event.duration == 0;
    if (isDone) {
      emit(const TimerRunComplete());
    } else {
      emit(TimerRunInProgress(event.duration));
    }
  }
}
