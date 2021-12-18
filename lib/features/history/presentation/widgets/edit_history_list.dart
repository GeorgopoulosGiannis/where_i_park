import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/history/presentation/bloc/history_bloc.dart';

class EditHistoryList extends StatelessWidget {
  const EditHistoryList({
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

            return ListTile(
              selectedTileColor: Colors.grey,
              selected: state.selected.contains(loc),
              onTap: () {
                if (state.selected.contains(loc)) {
                  context.read<HistoryBloc>().add(DeSelectLocationEvent(loc));
                  
                } else {
                  context.read<HistoryBloc>().add(SelectLocationEvent(loc));
                }
              },
              title: Text(
                loc.device?.name ?? 'Saved manually',
                style: state.selected.contains(loc)
                    ? const TextStyle(color: Colors.white)
                    : null,
              ),
              subtitle: Text(
                Helpers.toLocaleDateString(loc.position.timestamp!),
                style: state.selected.contains(loc)
                    ? const TextStyle(color: Colors.white)
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}
