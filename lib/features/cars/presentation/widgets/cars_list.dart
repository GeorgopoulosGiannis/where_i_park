import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is Loaded) {
          return ListView.builder(
            itemCount: state.cars.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(state.cars[i].name),
                subtitle: Text(state.cars[i].address),
                trailing: state.cars[i].isConnected
                    ? const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      )
                    : null,
                tileColor: i % 2 != 0 ? Colors.grey[200] : null,
                onTap: () {},
              );
            },
          );
        }
        if (state is Empty) {
          return  Center(
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
