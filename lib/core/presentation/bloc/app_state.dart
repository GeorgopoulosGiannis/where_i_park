part of 'app_bloc.dart';

class AppState extends Equatable {
  final String connectedDevice;
  const AppState({
    required this.connectedDevice,
  });

  @override
  List<Object> get props => [connectedDevice];
}
