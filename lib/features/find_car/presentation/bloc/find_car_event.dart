part of 'find_car_bloc.dart';

abstract class FindCarEvent extends Equatable {
  const FindCarEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends FindCarEvent {
  const LoadEvent();
}
