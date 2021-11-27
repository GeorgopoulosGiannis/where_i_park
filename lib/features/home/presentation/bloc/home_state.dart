part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class Idle extends HomeState {}
class GettingLocation extends HomeState {}
class SavedLocation extends HomeState {}
class FailedToSaveLocation extends HomeState {}
