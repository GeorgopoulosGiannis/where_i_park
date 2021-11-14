import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/core/presentation/bloc/app_bloc.dart';
import 'package:where_i_park/features/car_locations/presentation/bloc/car_locations_bloc.dart'
    show CarLocationsBloc, LoadCarLocations;
import 'package:where_i_park/features/car_locations/presentation/pages/car_locations_screen.dart';
import 'package:where_i_park/features/map/presentation/bloc/map_bloc.dart';

import 'package:where_i_park/services/injector.dart';

import '../bloc/cars_bloc.dart';

class CarsList extends StatelessWidget {
  const CarsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        return BlocBuilder<CarsBloc, CarsState>(
          builder: (context, state) {
            if (state is Error) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == Status.loaded) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.cars.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Row(children: [
                      Text(state.cars[i].name),
                      const SizedBox(width: 15),
                      if (state.cars[i].address == appState.connectedDevice)
                        const CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        )
                    ]),
                    subtitle: Text(state.cars[i].address),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                    tileColor: i % 2 != 0 ? Colors.grey[200] : null,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => sl<CarLocationsBloc>(
                              param1: state.cars[i],
                            )..add(LoadCarLocations(state.cars[i])),
                            child: const CarLocationsScreen(),
                          ),
                          //  BlocProvider<MapBloc>(
                          //   create: (context) => sl<MapBloc>()
                          //     ..add(
                          //       LoadMarkersForCar(
                          //         state.cars[i],
                          //       ),
                          //     ),
                          //   child: MapScreen(
                          //     car: state.cars[i],
                          //   ),
                          // ),
                        ),
                      );
                    },
                  );
                },
              );
            }
            if (state.status == Status.empty) {
              return Center(
                child: Text(
                  'No cars added to watchlist yet!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }
            return const Center(
              child: Text('Should not be in this state'),
            );
          },
        );
      },
    );
  }
}
