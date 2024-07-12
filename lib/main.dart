import 'dart:io';

import 'package:bloc_practice/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/home.dart';

class SimpleBlocObserver extends BlocObserver {

  const SimpleBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    print("${bloc.runtimeType} $change");
    super.onChange(bloc, change);
  }

}

void main() async {
  Bloc.observer = SimpleBlocObserver();
  // CounterCubit()
  //   ..increment()
  //   ..close();

  final bloc = CounterBloc();
  print(bloc.state);
  bloc.add(CounterIncrementPressed());
  // 블록 변화가 보통 한턴 늦어서, 이렇게 구문을 하나 중간에 넣어줘서 확인해야 함.
  await Future.delayed(Duration.zero);
  print(bloc.state);
  await bloc.close();

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
