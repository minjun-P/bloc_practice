import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';


class SimpleBlocObserver extends BlocObserver {
  const SimpleBlocObserver();

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc,
      Transition<dynamic, dynamic> transition,
      ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const App());
}