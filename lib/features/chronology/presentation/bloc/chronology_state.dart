part of 'chronology_bloc.dart';

abstract class ChronologyState extends Equatable {
  const ChronologyState();

  @override
  List<Object> get props => [];
}

class Loading extends ChronologyState {}

class Loaded extends ChronologyState {
  final List<CarLocation> locations;

  const Loaded(this.locations);
}
