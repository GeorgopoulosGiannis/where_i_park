// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      tracking: $enumDecode(_$TrackMethodEnumMap, json['tracking']),
      name: json['name'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'tracking': _$TrackMethodEnumMap[instance.tracking],
    };

const _$TrackMethodEnumMap = {
  TrackMethod.automatic: 'automatic',
  TrackMethod.notification: 'notification',
};
