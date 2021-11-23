import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/presentation/pages/cars_screen.dart';
import 'package:where_i_park/features/manual_tracker/presentation/pages/manual_tracking_screen.dart';
import 'package:where_i_park/features/speed_tracker/presentation/pages/speed_tracking_screen.dart';

import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.index == 0) {
            return const SpeedTrackingScreen();
          }
          if (state.index == 2) {
            return const ManualTrackingScreen();
          }
          return const CarsScreen();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => context.read<HomeCubit>().switchView(index),
        currentIndex: context.watch<HomeCubit>().state.index,
        items: const [
          BottomNavigationBarItem(
            label: 'Speed',
            icon: Icon(
              Icons.speed,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Bluetooth',
            icon: Icon(
              Icons.bluetooth,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Manual',
            icon: Icon(
              Icons.touch_app,
            ),
          ),
        ],
      ),
    );
  }
}
