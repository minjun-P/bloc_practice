part of 'post_bloc.dart';
// 이번 PostEvent는 심플하게 single event이다.
// 싱글 이벤트인 경우는 보통 데이터를 불러올 일만 있는 경우가 많을 것이다.
sealed class PostEvent extends Equatable {
}

final class PostFetched extends PostEvent {

  @override
  List<Object> get props => [];
}