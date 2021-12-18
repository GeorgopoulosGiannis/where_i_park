import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:where_i_park/features/history/presentation/bloc/history_bloc.dart';
import 'package:where_i_park/features/history/presentation/pages/history_screen.dart';

import 'package:where_i_park/features/find_car/presentation/bloc/find_car_bloc.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/find_car_map.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/map_location_card.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/no_locations.dart';
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
    return BlocProvider<FindCarBloc>(
      create: (context) => sl<FindCarBloc>()
        ..add(
          const LoadLastEvent(),
        ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: HistoryButton(),
              ),
            ],
          ),
          body: BlocBuilder<FindCarBloc, FindCarState>(
            builder: (context, state) {
              if (state.status == _S.loading) {
                return const Center(
                  child: Hero(
                    tag: 'gps_icon',
                    child: HomeItemIconContainer(
                      child: RiveAnimation.asset(
                        'assets/rive/gps.riv',
                        fit: BoxFit.contain,
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
              if (state.status == _S.loaded || state.status == _S.noLocation) {
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
                      child: state.status == _S.loaded
                          ? MapLocationCard(
                              location: state.location!,
                            )
                          : const NoLocations(),
                    ),
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

class HistoryButton extends StatelessWidget {
  const HistoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindCarBloc, FindCarState>(
      builder: (context, state) {
        if (state.status == _S.loaded) {
          return TextButton.icon(
            onPressed: () async {
              await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return const HistoryScreen();
                  },
                ),
              );
              context.read<FindCarBloc>().add(const LoadLastEvent());
            },
            icon: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            label: Text(
              'History',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
