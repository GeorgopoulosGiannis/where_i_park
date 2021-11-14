import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/car_locations/presentation/bloc/car_locations_bloc.dart';
import 'package:where_i_park/features/car_locations/presentation/widgets/clear_locations_button.dart';
import 'package:where_i_park/features/car_locations/presentation/widgets/list_view_button.dart';
import 'package:where_i_park/features/car_locations/presentation/widgets/locations_list.dart';
import 'package:where_i_park/features/car_locations/presentation/widgets/map_view_button.dart';
import 'package:where_i_park/features/map/presentation/bloc/map_bloc.dart'
    show LoadMarkersForCar, MapBloc;
import 'package:where_i_park/features/map/presentation/widgets/locations_map.dart';
import 'package:where_i_park/services/injector.dart';

class CarLocationsScreen extends StatelessWidget {
  const CarLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarLocationsBloc, CarLocationsState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: [
                if (state is Loaded)
                  state.viewStyle == ViewStyle.list
                      ? const MapViewButton()
                      : const ListViewButton(),
                const ClearLocationsButton(),
              ],
            ),
            body: () {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is Error) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is Loaded) {
                if (state.viewStyle == ViewStyle.map) {
                  return BlocProvider(
                    create: (context) => sl<MapBloc>()
                      ..add(LoadMarkersForCar(
                        state.car,
                        state.locations.map((e) => e.position).toList(),
                      )),
                    child: const LocationsMap(),
                  );
                }
                if (state.viewStyle == ViewStyle.list) {
                  return LocationsList(locations: state.locations);
                }
              }
            }(),
          ),
        );
      },
    );
  }
}
