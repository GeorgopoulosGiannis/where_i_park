import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wakelock/wakelock.dart';
import 'package:where_i_park/features/home/presentation/bloc/home_bloc.dart';

import 'services/injector.dart';
import 'services/bluetooth_manager.dart';

import 'features/home/presentation/home_screen.dart';

void main() async {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Wakelock.enable();
    await configureDependencies();
    await BluetoothManager.init();

    runApp(const MyApp());
  });
}

Future<void> onSelectNotification(String? payload) async {
  print(payload);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => sl<HomeBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Where did i park?',
        theme: ThemeData.from(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(100, 156, 166, 1),
            secondary:Color.fromRGBO(172, 196, 204, 1)
          ),
        ),
        home: const SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
