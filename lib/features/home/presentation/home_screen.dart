import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:where_i_park/core/presentation/widgets/dialogs.dart';
import 'package:where_i_park/features/add_device/presentation/pages/add_device_screen.dart';

import 'package:where_i_park/features/find_car/presentation/pages/find_car_screen.dart';
import 'package:where_i_park/features/home/presentation/widgets/home_drawer.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _riveController = SimpleAnimation('Animation 1');

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
      developer.log('${notificationAppLaunchDetails?.payload}');
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
        key: _scaffoldKey,
        drawer: const HomeDrawer(),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                  ),
                  child: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: theme.colorScheme.primaryVariant,
                      size: 40,
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: HomeItem(
                  title: 'Find',
                  subtitle: 'Car',
                  icon: Hero(
                    tag: 'gps_icon',
                    child: RiveAnimation.asset(
                      'assets/rive/gps.riv',
                      controllers: [_riveController],
                      fit: BoxFit.contain,
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
                child: Hero(
                  tag: 'bluetooth_icon',
                  child: HomeItem(
                    title: 'Add',
                    subtitle: 'Bluetooth',
                    icon: Icon(
                      Icons.bluetooth_drive,
                      color: theme.colorScheme.onPrimary,
                      size: 65,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) {
                            return const AddDeviceScreen();
                          },
                        ),
                      );
                    },
                  ),
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
                  icon: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          if (state is! GettingLocation)
                            Icon(
                              Icons.touch_app,
                              color: theme.colorScheme.onPrimary,
                              size: 65,
                            ),
                          if (state is GettingLocation)
                            const SizedBox(
                              height: 100,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                        ],
                      );
                    },
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
      ),
    );
  }
}
