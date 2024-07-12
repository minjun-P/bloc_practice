import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/timer_bloc.dart';
import '../ticker.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Timer'),
      ),
      body: Stack(
        children: [
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: TimerText(),
                ),
              ),
              Actions(),
            ],
          )
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch의 고급 버전, 특정 필드만을 가져와서 해당 값이 변할 때만 rebuild하게끔 한다.
    // 근데 위젯을 감싸는 것도 아니고 그냥 이렇게 변수 선언만 했는데 rebuild되는게 좀 신기하네. 원리가
    // 뭔지는 잘 모르겠다.
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);

    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      // 이렇게 해야 매번 다른 duration을 품고 있는 TimerTicked State가 emit될때마다
      // Rebuild를 하지 않는 불상사가 없을 수 있다.
      buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerStarted(duration: state.duration)),
                ),
              ],
              TimerRunInProgress() => [
                FloatingActionButton(
                  child: const Icon(Icons.pause),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerPaused()),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
              TimerRunPause() => [
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerResumed()),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
              TimerRunComplete() => [
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ]
            }
          ],
        );
      },
    );
  }
}


class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade500,
          ],
        ),
      ),
    );
  }
}
