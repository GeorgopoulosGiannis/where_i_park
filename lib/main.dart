import 'dart:developer' as developer;
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    runApp(const MyApp());
  });
}

Future<void> onSelectNotification(String? payload) async {
  developer.log(payload.toString());
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
          colorScheme: ColorScheme.light(
            primary: Colors.blue[200]!, //Color.fromRGBO(100, 156, 166, 1),
            primaryVariant: Colors.blue, //  Color.fromRGBO(172, 196, 204, 1)
            surface: Colors.grey[300]!,
            
          ),
        ).copyWith(
          scaffoldBackgroundColor: Colors.white, // Colors.grey[300]!,
          appBarTheme: const AppBarTheme(
            color: Colors.blue,
          ),
        ),
        home: const SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
