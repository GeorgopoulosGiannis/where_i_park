import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';

const defPosition = LatLng(
  37.97203839626765,
  23.734829686005977,
);

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);

  final imageDescriptor = await ui.ImageDescriptor.encoded(
    await ui.ImmutableBuffer.fromUint8List(
      data.buffer.asUint8List(),
    ),
  );

  ui.FrameInfo fi = await (await imageDescriptor.instantiateCodec(
    targetHeight: 150,
  ))
      .getNextFrame();
  return (await fi.image.toByteData(
    format: ui.ImageByteFormat.png,
  ))!
      .buffer
      .asUint8List();
}

class FindCarMap extends StatefulWidget {
  final List<CarLocation> locations;

  const FindCarMap({
    Key? key,
    required this.locations,
  }) : super(key: key);

  @override
  State<FindCarMap> createState() => _FindCarMapState();
}

class _FindCarMapState extends State<FindCarMap> {
  GoogleMapController? _controller;
  late Future<BitmapDescriptor> icon;

  @override
  void initState() {
    icon = loadIcon();
    super.initState();
  }

  Future<BitmapDescriptor> loadIcon() async {
    final result = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/car_icon.png', 200));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BitmapDescriptor>(
      future: icon,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: defPosition,
              zoom: 12,
            ),
            mapToolbarEnabled: false,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: widget.locations
                .map(
                  (loc) => Marker(
                    icon: snapshot.data!, //?? BitmapDescriptor.defaultMarker,
                    markerId: const MarkerId(
                      'markerID',
                    ),
                    position: LatLng(
                      loc.position.latitude,
                      loc.position.longitude,
                    ),
                    onTap: () {},
                  ),
                )
                .toSet(),
            onMapCreated: (mapController) {
              _controller = mapController;
              if (widget.locations.isNotEmpty) {
                final loc = widget.locations.first;
                _controller!.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(
                      loc.position.latitude,
                      loc.position.longitude,
                    ),
                    15,
                  ),
                );
              }
            },
          );
        }
        return Container();
      },
    );
  }
}
