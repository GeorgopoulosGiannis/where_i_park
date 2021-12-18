import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/history/presentation/bloc/history_bloc.dart';
import 'package:where_i_park/features/history/presentation/widgets/edit_history_list.dart';
import 'package:where_i_park/features/history/presentation/widgets/history_list.dart';
import 'package:where_i_park/services/injector.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HistoryBloc>()
        ..add(
          LoadLocationsEvent(),
        ),
      child: SafeArea(
        child:
            BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: state.status == Status.editing
                  ? IconButton(
                      onPressed: () {
                        context.read<HistoryBloc>().add(StopEditEvent());
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    )
                  : null,
              actions: state.status == Status.editing
                  ? [
                      TextButton.icon(
                        onPressed: state.selected.isNotEmpty
                            ? () {
                                context
                                    .read<HistoryBloc>()
                                    .add(DeleteSelectedEvent());
                              }
                            : null,
                        icon: Icon(
                          Icons.delete,
                          color: state.selected.isNotEmpty
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                        label: Text(
                          'Delete selected',
                          style: TextStyle(
                            color: state.selected.isNotEmpty
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ]
                  : null,
              backgroundColor:
                  state.status == Status.editing ? Colors.red : null,
            ),
            body: () {
              if (state.status == Status.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == Status.empty) {
                final theme = Theme.of(context);
                return Center(
                  child: Text(
                    'No locations have been saved yet 😞',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline6,
                  ),
                );
              }
              if (state.status == Status.loaded) {
                return const HistoryList();
              }
              if (state.status == Status.editing) {
                return const EditHistoryList();
              }
              return Container();
            }(),
          );
        }),
      ),
    );
  }
}
