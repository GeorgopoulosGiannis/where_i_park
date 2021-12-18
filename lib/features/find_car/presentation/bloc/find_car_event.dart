part of 'find_car_bloc.dart';

abstract class FindCarEvent extends Equatable {
  const FindCarEvent();

  @override
  List<Object> get props => [];
}

class LoadLastEvent extends FindCarEvent {
  const LoadLastEvent();
}

class LoadForLocationEvt extends FindCarEvent {
  final CarLocation location;
  const LoadForLocationEvt(this.location);
}

class PositionChangedEvent extends FindCarEvent {
  final Position position;

  const PositionChangedEvent(this.position);
}

class DeleteLocationEvent extends FindCarEvent {
  final CarLocation location;

  const DeleteLocationEvent(this.location);
}
