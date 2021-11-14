// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BluetoothDeviceModel _$BluetoothDeviceModelFromJson(
        Map<String, dynamic> json) =>
    BluetoothDeviceModel(
      address: json['address'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BluetoothDeviceModelToJson(
        BluetoothDeviceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
    };
