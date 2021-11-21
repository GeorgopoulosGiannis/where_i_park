import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/presentation/bloc/car_locations_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/presentation/widgets/clear_locations_button.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/presentation/widgets/list_view_button.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/presentation/widgets/locations_list.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/presentation/widgets/map_view_button.dart';

import 'package:where_i_park/features/bluetooth_tracker/map/presentation/bloc/map_bloc.dart'
    show LoadMarkersForCar, MapBloc;
import 'package:where_i_park/features/bluetooth_tracker/map/presentation/widgets/location_card.dart';
import 'package:where_i_park/features/bluetooth_tracker/map/presentation/widgets/locations_map.dart';
import 'package:where_i_park/services/injector.dart';

class CarLocationsScreen extends StatelessWidget {
  const CarLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarLocationsBloc, CarLocationsState>(
      builder: (context, state) {
        return SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              return !state.isEdit;
            },
            child: Scaffold(
              appBar: AppBar(
                title: state.status == CarLocationStatus.loaded
                    ? Text(state.car.name)
                    : null,
                backgroundColor: state.isEdit ? Colors.red : null,
                leading: state.isEdit
                    ? IconButton(
                        onPressed: () {
                          context
                              .read<CarLocationsBloc>()
                              .add(SwitchCarLocationsEditState());
                        },
                        icon: const Icon(Icons.cancel),
                      )
                    : null,
                actions: [
                  if (state.status == CarLocationStatus.loaded && !state.isEdit)
                    state.viewStyle == ViewStyle.list
                        ? const MapViewButton()
                        : const ListViewButton(),
                  if (state.isEdit) const ClearLocationsButton(),
                ],
              ),
              body: () {
                if (state.status == CarLocationStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.status == CarLocationStatus.error) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state.status == CarLocationStatus.loaded) {
                  if (state.locations.isEmpty) {
                    return const Center(
                      child: Text('No Locations saved for this car yet!'),
                    );
                  }
                  if (state.viewStyle == ViewStyle.map) {
                    return BlocProvider(
                      create: (context) => sl<MapBloc>()
                        ..add(LoadMarkersForCar(
                          state.car,
                          state.locations,
                        )),
                      child: Column(
                        children: [
                          const Flexible(
                            flex: 3,
                            child: LocationsMap(),
                          ),
                          Flexible(
                            child: ColoredBox(
                              color: Colors
                                  .white, 
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.locations.length,
                                itemBuilder: (context, i) {
                                  final location = state.locations[i];
                                  return LocationCard(location: location);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state.viewStyle == ViewStyle.list) {
                    return LocationsList(
                      locations: state.locations,
                    );
                  }
                }
              }(),
            ),
          ),
        );
      },
    );
  }
}
