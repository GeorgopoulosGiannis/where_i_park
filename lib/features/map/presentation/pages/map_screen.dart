import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:where_i_park/features/map/presentation/bloc/map_bloc.dart';
import 'package:where_i_park/services/injector.dart';

import '../../../cars/domain/entities/car.dart';

class MapScreen extends StatefulWidget {
  final Car car;
  const MapScreen({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  void initState() {
    if (Platform.isAndroid) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    final lastLocation = widget.car.previousLocations.last;
    final cameraPosition = CameraPosition(
      target: LatLng(lastLocation.latitude, lastLocation.longitude),
      zoom: 19.151926040649414,
    );
    createMarkers();
    _goToLastPosition(cameraPosition);
    super.initState();
  }

  Future<void> createMarkers() async {
    for (var position in widget.car.previousLocations) {
      var i = 0;
      final markerId = MarkerId('${widget.car.address}-$i');
      final marker = Marker(
        markerId: markerId,
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: widget.car.name, snippet: '*'),
        onTap: () {},
      );
      markers[markerId] = marker;
      setState(() {});
    }
  }

  Future<void> _goToLastPosition(CameraPosition position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (context) => sl<MapBloc>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Builder(
                builder: (context) {
                  return IconButton(
                      onPressed: () {
                        context.read<MapBloc>().add(ClearAll(widget.car));
                      },
                      icon: const Icon(
                        Icons.clear_all,
                      ));
                }
              )
            ],
          ),
          body: Center(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kLake,
              markers: Set<Marker>.of(markers.values),
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ),
      ),
    );
  }
}
