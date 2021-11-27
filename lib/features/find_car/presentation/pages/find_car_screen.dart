import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:where_i_park/features/find_car/presentation/bloc/find_car_bloc.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/find_car_map.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/map_location_card.dart';
import 'package:where_i_park/features/home/presentation/widgets/home_item_icon_container.dart';
import 'package:where_i_park/services/injector.dart';

typedef _S = FindCarStatus;

class FindCarScreen extends StatefulWidget {
  const FindCarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FindCarScreen> createState() => _FindCarScreenState();
}

class _FindCarScreenState extends State<FindCarScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<FindCarBloc>(
      create: (context) => sl<FindCarBloc>()
        ..add(
          const LoadEvent(),
        ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<FindCarBloc, FindCarState>(
            builder: (context, state) {
              if (state.status == _S.loading) {
                return Center(
                  child: Hero(
                    tag: 'car_icon',
                    child: HomeItemIconContainer(
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        color: theme.colorScheme.onPrimary,
                        size: 65,
                      ),
                    ),
                  ),
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
                      flex: 2,
                      child: FindCarMap(
                        locations: [
                          if (state.location != null) state.location!,
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          MapLocationCard(
                            location: state.location,
                          ),
                          MapLocationCard(
                            location: state.location,
                          ),
                        ],
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
