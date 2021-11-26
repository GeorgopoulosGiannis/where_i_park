import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/find_car/presentation/bloc/find_car_bloc.dart';

class MapLocationCard extends StatelessWidget {
  final CarLocation? location;
  const MapLocationCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.7;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 4,
        ),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              Helpers.toLocaleDateString(location!.position.timestamp!),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
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
          BlocBuilder<FindCarBloc, FindCarState>(
            builder: (context, state) {
              return Text('Distance: ${state.distance}');
            },
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
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    MapsLauncher.launchCoordinates(
                      location!.position.latitude,
                      location!.position.longitude,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Get Directions',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const Icon(
                          Icons.directions_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
