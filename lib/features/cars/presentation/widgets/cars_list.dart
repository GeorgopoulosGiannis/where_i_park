import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/core/presentation/bloc/app_bloc.dart';
import 'package:where_i_park/features/car_locations/presentation/bloc/car_locations_bloc.dart'
    show CarLocationsBloc, LoadCarLocations;
import 'package:where_i_park/features/car_locations/presentation/pages/car_locations_screen.dart';

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
                    tileColor: state.selected.contains(state.cars[i])
                        ? Theme.of(context).highlightColor
                        : null,
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
                    trailing: state.isEdit
                        ? null
                        : const Icon(
                            Icons.chevron_right,
                          ),
                    onTap: state.isEdit
                        ? () {
                            context
                                .read<CarsBloc>()
                                .add(SelectCar(state.cars[i]));
                          }
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => sl<CarLocationsBloc>(
                                    param1: state.cars[i],
                                  )..add(LoadCarLocations(state.cars[i])),
                                  child: const CarLocationsScreen(),
                                ),
                              ),
                            );
                          },
                    onLongPress: state.isEdit
                        ? null
                        : () {
                            context.read<CarsBloc>().add(SwitchEditState());
                            context
                                .read<CarsBloc>()
                                .add(SelectCar(state.cars[i]));
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
