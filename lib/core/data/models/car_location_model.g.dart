// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarLocationModel _$CarLocationModelFromJson(Map<String, dynamic> json) =>
    CarLocationModel(
      positionModel: const PositionConverter()
          .fromJson(json['positionModel'] as Map<String, dynamic>),
      deviceModel: json['deviceModel'] == null
          ? null
          : BluetoothDeviceModel.fromJson(
              json['deviceModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarLocationModelToJson(CarLocationModel instance) =>
    <String, dynamic>{
      'deviceModel': instance.deviceModel,
      'positionModel': const PositionConverter().toJson(instance.positionModel),
    };
