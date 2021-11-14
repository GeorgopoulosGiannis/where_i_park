import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_i_park/features/car_locations/presentation/bloc/car_locations_bloc.dart';

class ListViewButton extends StatelessWidget {
  const ListViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<CarLocationsBloc>().add(ViewAsList());
      },
      icon: const Icon(Icons.list),
    );
  }
}
