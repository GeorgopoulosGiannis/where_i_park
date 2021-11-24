import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/manual_tracker/presentation/cubit/manual_tracker_cubit.dart';
import 'package:where_i_park/features/manual_tracker/presentation/widgets/manual_tracking_map.dart';
import 'package:where_i_park/services/injector.dart';

class ManualTrackingScreen extends StatelessWidget {
  const ManualTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ManualTrackerCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Builder(
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Theme.of(context).colorScheme.primary,
                    child: Ink(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.read<ManualTrackerCubit>().saveCurrent();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                Text(
                                  'Save location',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                );
              }
            )
          ],
        ),
        body: const ManualTrackingMap(),
      ),
    );
  }
}
