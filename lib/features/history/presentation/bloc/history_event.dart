part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadLocationsEvent extends HistoryEvent {}

class EditEvent extends HistoryEvent {}

class StopEditEvent extends HistoryEvent {}

class DeleteSelectedEvent extends HistoryEvent {}

class SelectLocationEvent extends HistoryEvent {
  final CarLocation loc;

  const SelectLocationEvent(this.loc);
}
class DeSelectLocationEvent extends HistoryEvent {
  final CarLocation loc;

  const DeSelectLocationEvent(this.loc);
}
