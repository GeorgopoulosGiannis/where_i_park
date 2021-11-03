import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wakelock/wakelock.dart';

import 'services/injector.dart';

import 'features/home/presentation/home_screen.dart';
import 'features/cars/presentation/bloc/cars_bloc.dart';

void main() async {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Wakelock.enable();
    await configureDependencies();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Where did i park?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<CarsBloc>(),
          ),
      
        ],
        child: const SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
