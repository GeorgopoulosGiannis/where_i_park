import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:where_i_park/core/presentation/widgets/dialogs.dart';

import 'package:where_i_park/features/find_car/presentation/pages/find_car_screen.dart';
import 'package:where_i_park/features/home/presentation/widgets/home_item.dart';
import 'package:where_i_park/services/notification_manager.dart';

import 'bloc/home_bloc.dart';

const verticalPadding = 0.0;
const horizontalPadding = 15.0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    checkLocalNotification();
    super.initState();
  }

  Future<void> checkLocalNotification() async {
    await NotificationManager.initialize();
    final notificationAppLaunchDetails = await NotificationManager
        .flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      print(notificationAppLaunchDetails?.payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is SavedLocation) {
          showDialog(
            context: context,
            builder: (context) => const SuccessDialog(
              body: '',
              title: 'Location Saved!',
            ),
          );
        }
        if (state is FailedToSaveLocation) {
          showDialog(
            context: context,
            builder: (context) => const ErrorDialog(
              body: '',
              title: 'Failed to Save Location :(',
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: HomeItem(
                  text: 'Find\nCar',
                  icon: Icons.car_rental,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const FindCarScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: HomeItem(
                  text: 'Add\nBluetooth',
                  icon: Icons.bluetooth,
                  onTap: () {},
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: HomeItem(
                  text: 'Save\nPosition',
                  icon: Icons.location_on,
                  onTap: () {
                    context.read<HomeBloc>().add(const SaveLocationEvent());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
