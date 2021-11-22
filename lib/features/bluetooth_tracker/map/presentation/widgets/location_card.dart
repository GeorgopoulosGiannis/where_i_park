import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';

import 'package:where_i_park/features/bluetooth_tracker/map/presentation/bloc/map_bloc.dart';

class LocationCard extends StatelessWidget {
  final CarLocation location;
  const LocationCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.7;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: cardWidth,
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
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              '${location.placemark.locality}, ${location.placemark.street}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            Helpers.toLocaleDateString(location.position.timestamp!),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  spreadRadius: 3,
                )
              ],
            ),
            child: Ink(
              width: cardWidth * 0.6,
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
                child: InkWell(
                  onTap: () {
                    MapsLauncher.launchCoordinates(location.position.latitude, location.position.longitude);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Icon(
                      Icons.assistant_navigation,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      //  ),
    );
  }
}
