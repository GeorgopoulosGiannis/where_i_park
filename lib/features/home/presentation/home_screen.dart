import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
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
  final _riveController = SimpleAnimation('active');
  final _riveCarController = SimpleAnimation('active');
  @override
  void initState() {
    _riveController.isActive = true;
    _riveCarController.isActive = true;
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
    final theme = Theme.of(context);
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
        body: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: HomeItem(
                  title: 'Find',
                  subtitle: 'Car',
                  icon: SizedBox(
                    height: 80,
                    width: 80,
                    child: Icon(
                      Icons.directions_car_filled_rounded,
                      color: theme.colorScheme.onPrimary,
                      size: 65,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
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
                  title: 'Add',
                  subtitle: 'Bluetooth',
                  icon:  SizedBox(
                    height: 80,
                    width: 80,
                    child: Icon(
                      Icons.bluetooth,
                      color: theme.colorScheme.onPrimary,
                      size: 65,
                    ),
                  ),
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
                  title: 'Save',
                  subtitle: 'Position',
                  icon: SizedBox(
                    height: 80,
                    width: 80,
                    child: RiveAnimation.asset(
                      'assets/rive/gps.riv',
                      controllers: [_riveController],
                      fit: BoxFit.contain,
                    ),
                  ),
                  onTap: () {
                    context.read<HomeBloc>().add(const SaveLocationEvent());
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Icon(
          Icons.menu,
          color: theme.colorScheme.primary,
          size: 40,
        ),
      ),
    );
  }
}
