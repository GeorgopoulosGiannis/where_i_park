import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_i_park/features/car_locations/presentation/bloc/car_locations_bloc.dart';

class ClearLocationsButton extends StatelessWidget {
  const ClearLocationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: context.watch<CarLocationsBloc>().state.selected.isNotEmpty
            ? () {
                context.read<CarLocationsBloc>().add(const ClearSelected());
              }
            : null,
        icon: const Icon(
          Icons.delete_forever_rounded,
        ));
  }
}
