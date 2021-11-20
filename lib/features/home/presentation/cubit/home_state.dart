part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  final int index;
  const HomeState(this.index);
}

class HomeSpeedState extends HomeState {
  const HomeSpeedState() : super(0);
}


class HomeBluetoothState extends HomeState {
  const HomeBluetoothState() : super(1);
}


class HomeManualState extends HomeState {
  const HomeManualState() : super(2);
}
