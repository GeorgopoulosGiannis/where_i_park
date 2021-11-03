import 'package:equatable/equatable.dart';

class BluetoothDevice extends Equatable {
  final String name;
  final String address;
  final bool isConnected;

  const BluetoothDevice({
    required this.name,
    required this.address,
    required this.isConnected,
  });
  @override
  List<Object?> get props => [
        name,
        address,
        isConnected,
      ];
}
