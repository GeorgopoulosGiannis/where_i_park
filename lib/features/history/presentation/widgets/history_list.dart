import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/find_car/presentation/pages/show_location_screen.dart';
import 'package:where_i_park/features/history/presentation/bloc/history_bloc.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: state.locations.length,
          itemBuilder: (context, index) {
            final loc = state.locations[index];

            return GestureDetector(
              onLongPress: () {
                context.read<HistoryBloc>().add(EditEvent());
                context.read<HistoryBloc>().add(SelectLocationEvent(loc));
              },
              child: ListTile(
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
              ),
            );
          },
        );
      },
    );
  }
}
