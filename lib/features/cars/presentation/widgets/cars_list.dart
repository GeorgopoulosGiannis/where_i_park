import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/map/presentation/pages/map_screen.dart';

import '../bloc/cars_bloc.dart';

class CarsList extends StatelessWidget {
  const CarsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          return ListView.builder(
            itemCount: state.cars.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(state.cars[i].name),
                subtitle: Text(state.cars[i].address),
                trailing: state.cars[i].address == state.connectedAddress
                    ? const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      )
                    : null,
                tileColor: i % 2 != 0 ? Colors.grey[200] : null,
                onTap: state.cars[i].previousLocations.isNotEmpty
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              car: state.cars[i],
                            ),
                          ),
                        );
                      }
                    : null,
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
  }
}
