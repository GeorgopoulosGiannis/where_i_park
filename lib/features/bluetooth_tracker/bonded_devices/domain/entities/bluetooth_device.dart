import 'package:equatable/equatable.dart';

class BluetoothDevice extends Equatable {
  final String name;
  final String address;

  const BluetoothDevice({
    required this.name,
    required this.address,
  });
  @override
  List<Object?> get props => [
        name,
        address,
      ];
}
