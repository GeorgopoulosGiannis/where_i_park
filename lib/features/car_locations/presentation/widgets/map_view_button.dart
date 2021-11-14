import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_i_park/features/car_locations/presentation/bloc/car_locations_bloc.dart';

class MapViewButton extends StatelessWidget {
  const MapViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<CarLocationsBloc>().add(ViewAsMap());
      },
      icon: const Icon(
        Icons.map,
      ),
    );
  }
}
