import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:where_i_park/features/car_locations/domain/entities/car_location.dart';

class LocationsList extends StatelessWidget {
  final List<CarLocation> locations;
  const LocationsList({
    Key? key,
    required this.locations,
  }) : super(key: key);

  String _titleFromPlaceMark(Placemark mark) {
    return '${mark.locality},${mark.street} ';
  }

  String _subtitleFromPosition(Position position) {
    return position.timestamp != null
        ? DateFormat('dd-MM-yyyy - kk:mm').format(position.timestamp!)
        : '-';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      shrinkWrap: true,
      itemCount: locations.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, i) => ListTile(
        title: Text(
          _titleFromPlaceMark(locations[i].placemark),
        ),
        subtitle: Text(
          _subtitleFromPosition(locations[i].position),
        ),
      ),
    );
  }
}
