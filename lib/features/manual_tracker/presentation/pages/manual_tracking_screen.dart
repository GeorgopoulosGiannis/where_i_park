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
        appBar: AppBar(),
        body: const ManualTrackingMap(),
      ),
    );
  }
}
