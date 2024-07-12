import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'timer_observer.dart';

void main() {
  Bloc.observer = TimerObserver();
  runApp(const App());
}