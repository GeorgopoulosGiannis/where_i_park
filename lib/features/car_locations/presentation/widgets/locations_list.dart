import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:where_i_park/core/helpers/helpers.dart';

import 'package:where_i_park/features/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/car_locations/presentation/bloc/car_locations_bloc.dart';

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
        ?Helpers.toLocaleDateString(position.timestamp!)
        : '-';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
    
      itemCount: locations.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, i) => ListTile(
        title: Text(
          _titleFromPlaceMark(locations[i].placemark),
        ),
        subtitle: Text(
          _subtitleFromPosition(locations[i].position),
        ),
        onLongPress: context.watch<CarLocationsBloc>().state.isEdit
            ? null
            : () {
                context.read<CarLocationsBloc>().add(SwitchEditState());
                context
                    .read<CarLocationsBloc>()
                    .add(AddToSelected(locations[i]));
              },
        onTap: context.watch<CarLocationsBloc>().state.isEdit
            ? () {
                context
                    .read<CarLocationsBloc>()
                    .add(AddToSelected(locations[i]));
              }
            : null,
        tileColor: context
                .watch<CarLocationsBloc>()
                .state
                .selected
                .contains(locations[i])
            ? Theme.of(context).highlightColor
            : null,
      ),
    );
  }
}
