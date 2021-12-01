import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/chronology/presentation/bloc/chronology_bloc.dart';
import 'package:where_i_park/features/find_car/presentation/pages/show_location_screen.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/find_car_map.dart';
import 'package:where_i_park/services/injector.dart';

class ChronologyScreen extends StatelessWidget {
  const ChronologyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChronologyBloc>()
        ..add(
          LoadLocationsEvent(),
        ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<ChronologyBloc, ChronologyState>(
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is Empty) {
                final theme = Theme.of(context);
                return Center(
                  child: Text(
                    'No locations have been saved yet 😞',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline6,
                  ),
                );
              }
              if (state is Loaded) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.locations.length,
                  itemBuilder: (context, index) {
                    final loc = state.locations[index];

                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) {
                              return ShowLocationScreen(location: loc);
                            },
                          ),
                        );
                      },
                      title: Text(loc.device?.name ?? 'Saved manually'),
                      subtitle: Text(
                        Helpers.toLocaleDateString(loc.position.timestamp!),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
