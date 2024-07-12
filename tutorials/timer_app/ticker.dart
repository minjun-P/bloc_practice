/// 1초에 한번씩 남은 값을 yield하는 Stream을 생성하는 클래스
/// 타이머 구현의 기초 부분
class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x -1).take(ticks);
  }
}