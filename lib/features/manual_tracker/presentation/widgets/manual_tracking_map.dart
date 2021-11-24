import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:where_i_park/features/manual_tracker/presentation/cubit/manual_tracker_cubit.dart';

class ManualTrackingMap extends StatelessWidget {
  const ManualTrackingMap({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManualTrackerCubit, ManualTrackerState>(
      builder: (context, state) {
        return state.initialPosition == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                markers: {
                  if (state.lastPosition != null)
                    Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(
                        state.lastPosition!.latitude,
                        state.lastPosition!.longitude,
                      ),
                    ),
                },
                initialCameraPosition: state.initialPosition!,
                myLocationEnabled: true,
              );
      },
    );
  }
}
