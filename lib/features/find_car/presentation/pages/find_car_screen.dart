import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:where_i_park/features/find_car/presentation/bloc/find_car_bloc.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/find_car_map.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/map_location_card.dart';
import 'package:where_i_park/services/injector.dart';

typedef _S = FindCarStatus;

class FindCarScreen extends StatelessWidget {
  const FindCarScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FindCarBloc>(
      create: (context) => sl<FindCarBloc>()
        ..add(
          const LoadEvent(),
        ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          backgroundColor: Theme.of(context).primaryColor,
          body: BlocBuilder<FindCarBloc, FindCarState>(
            builder: (context, state) {
              if (state.status == _S.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == _S.error) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state.status == _S.loaded) {
                return Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: FindCarMap(
                        locations: [
                          if (state.location != null) state.location!,
                        ],
                      ),
                    ),
                    Flexible(
                      child: MapLocationCard(
                        location: state.location,
                      ),
                    )
                  ],
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
