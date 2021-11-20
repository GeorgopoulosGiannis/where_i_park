import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:where_i_park/features/bluetooth_tracker/map/presentation/bloc/map_bloc.dart';

class LocationsMap extends StatefulWidget {
  const LocationsMap({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationsMap> createState() => _LocationsMapState();
}

class _LocationsMapState extends State<LocationsMap> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  void initState() {
    if (Platform.isAndroid) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listenWhen: (previous, current) =>
          previous.zoomedLocation != current.zoomedLocation,
      listener: (context, state) async {
        final mapController = await _controller.future;

        mapController.showMarkerInfoWindow(
            state.markers[state.zoomedLocation]!.markerId);
      },
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is Error) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state.status == Status.loaded) {
          return GoogleMap(
            mapToolbarEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: state.cameraPosition!,
            markers: Set<Marker>.of(state.markers.values),
            onMapCreated: (controller) {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
            },
          );
        }
        return Container();
      },
    );
  }
}
