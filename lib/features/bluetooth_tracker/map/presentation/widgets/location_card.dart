import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';

import 'package:where_i_park/features/bluetooth_tracker/map/presentation/bloc/map_bloc.dart';

class LocationCard extends StatelessWidget {
  final CarLocation location;
  const LocationCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: context.watch<MapBloc>().state.zoomedLocation == location
            ? Border.all(
                color: Colors.blue,
                width: 4,
              )
            : null,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(
              4,
              8,
            ),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          context.read<MapBloc>().add(SelectLocationEvt(location));
        },
        child: Column(
          children: [
            Text(
              '${location.placemark.locality}, ${location.placemark.street}\n',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              Helpers.toLocaleDateString(location.position.timestamp!),
            )
          ],
        ),
      ),
    );
  }
}
