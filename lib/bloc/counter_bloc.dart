import 'package:flutter_bloc/flutter_bloc.dart';

sealed class CounterEvent{}

// 공식문서 따라 친거긴 한데... final modifier가 class 앞에 붙는 경우 ->
// 더 이상 상속과 implement가 불가능한 클래스임을 정의하는 것.
final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {

  CounterBloc(): super(0) {
    // bloc이 cubit과 구분되는 지점 -> 직접 함수, 명령형으로 상태를 변경하지 않고, 이벤트핸들러로 정의
    on<CounterIncrementPressed>((event, emit) {
      emit(state + 1);
    });
  }
}