// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      name: json['name'] as String,
      address: json['address'] as String,
      isConnected: json['isConnected'] as bool,
      previousLocations:
          const PositionConverter().fromJson(json['previousLocations'] as List),
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'isConnected': instance.isConnected,
      'previousLocations':
          const PositionConverter().toJson(instance.previousLocations),
    };
