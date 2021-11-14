import 'package:flutter/material.dart';

import 'package:where_i_park/features/car_locations/domain/entities/car_location.dart';

class LocationsList extends StatelessWidget {
  final List<CarLocation> locations;
  const LocationsList({
    Key? key,
    required this.locations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      shrinkWrap: true,
      itemCount: locations.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => ListTile(
        title: Text(
            '${locations[index].placemark.locality},${locations[index].placemark.street} '),
        subtitle: Text(
          locations[index].position.timestamp?.toLocal().toString() ?? '',
        ),
      ),
    );
  }
}
