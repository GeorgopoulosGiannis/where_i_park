import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/find_car/presentation/bloc/find_car_bloc.dart';

class MapLocationCard extends StatefulWidget {
  final CarLocation? location;
  const MapLocationCard({Key? key, required this.location}) : super(key: key);

  @override
  State<MapLocationCard> createState() => _MapLocationCardState();
}

class _MapLocationCardState extends State<MapLocationCard> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardWidth = MediaQuery.of(context).size.width * 0.9;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      padding: const EdgeInsets.all(10),
      width: cardWidth,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            color: Colors.black38,
            blurRadius: 3,
            spreadRadius: 2,
          ),
        ],
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              Helpers.toLocaleDateString(widget.location!.position.timestamp!),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style:  TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<FindCarBloc, FindCarState>(
            builder: (context, state) {
              return Text(
                'Distance: ${state.distance}',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                ),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          DecoratedBox(
            decoration: const BoxDecoration(),
            child: Ink(
              width: cardWidth * 0.6,
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    MapsLauncher.launchCoordinates(
                      widget.location!.position.latitude,
                      widget.location!.position.longitude,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Get Directions',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                         Icon(
                          Icons.directions_sharp,
                          color: theme.colorScheme.onPrimary,
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
