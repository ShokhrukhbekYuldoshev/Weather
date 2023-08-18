part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final Weather weather;

  HomeLoaded(this.weather);
}

final class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}
