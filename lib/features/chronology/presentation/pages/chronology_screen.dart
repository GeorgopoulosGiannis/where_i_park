import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/chronology/presentation/bloc/chronology_bloc.dart';
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
              if (state is Loaded) {
                return ListView.builder(
                  itemCount: state.locations.length,
                  itemBuilder: (context, index) {
                    final loc = state.locations[index];

                    return ListTile(
                      title: Text(loc.device?.name ?? 'No device'),
                      subtitle: Text(
                        '${loc.position.toString()}\n${Helpers.toLocaleDateString(loc.position.timestamp!)}',
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
