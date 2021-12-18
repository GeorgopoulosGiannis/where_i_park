part of 'history_bloc.dart';

enum Status {
  loading,
  empty,
  loaded,
  editing,
}

class HistoryState extends Equatable {
  final Status status;
  final List<CarLocation> locations;
  final List<CarLocation> selected;

  const HistoryState({
    required this.status,
    required this.locations,
    required this.selected,
  });

  HistoryState copyWith({
    Status? status,
    List<CarLocation>? locations,
    List<CarLocation>? selected,
  }) =>
      HistoryState(
        locations: locations ?? this.locations,
        selected: selected ?? this.selected,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [
        locations,
        status,
        selected,
      ];
}
