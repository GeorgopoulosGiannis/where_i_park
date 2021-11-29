part of 'chronology_bloc.dart';

abstract class ChronologyEvent extends Equatable {
  const ChronologyEvent();

  @override
  List<Object> get props => [];
}

class LoadLocationsEvent extends ChronologyEvent {}
