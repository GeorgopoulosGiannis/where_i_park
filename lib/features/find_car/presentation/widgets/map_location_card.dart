import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/find_car/presentation/bloc/find_car_bloc.dart';
import 'package:where_i_park/features/find_car/presentation/widgets/card_actions_button.dart';

const smallPaddingBottom = SizedBox(
  height: 5,
);

class MapLocationCard extends StatelessWidget {
  final CarLocation location;
  const MapLocationCard({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _CardDecoration(
      color: theme.colorScheme.primary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: CardActionsButton(
                location: location,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (location.device != null)
                _DeviceDescriptionText(
                  text: location.device!.name,
                  color: theme.colorScheme.onPrimary,
                ),
              smallPaddingBottom,
              _TimeStampText(
                text: Helpers.toLocaleDateString(
                  location.position.timestamp!,
                ),
                color: theme.colorScheme.onPrimary,
              ),
              smallPaddingBottom,
              _DistanceText(
                color: theme.colorScheme.onPrimary,
              ),
              smallPaddingBottom,
              _GetDirectionsButton(
                position: location.position,
                backgroundColor: theme.colorScheme.primaryVariant,
                textColor: theme.colorScheme.onPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardDecoration extends StatelessWidget {
  final Widget child;
  final Color color;
  const _CardDecoration({
    Key? key,
    required this.child,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.9;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      padding: const EdgeInsets.all(10),
      width: cardWidth,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            color: Colors.black38,
            blurRadius: 3,
            spreadRadius: 2,
          ),
        ],
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}

class _DeviceDescriptionText extends StatelessWidget {
  final String text;
  final Color color;
  const _DeviceDescriptionText({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.subtitle1?.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

class _TimeStampText extends StatelessWidget {
  final String text;
  final Color color;
  const _TimeStampText({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      maxLines: 2,
      style: theme.textTheme.subtitle1?.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _DistanceText extends StatelessWidget {
  final Color color;
  const _DistanceText({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<FindCarBloc, FindCarState>(
      builder: (context, state) {
        return Text(
          'Distance: ${state.distance}',
          style: theme.textTheme.subtitle1?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

class _GetDirectionsButton extends StatelessWidget {
  final Position position;
  final Color backgroundColor;
  final Color textColor;
  const _GetDirectionsButton({
    Key? key,
    required this.position,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Ink(
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
        child: InkWell(
          onTap: () {
            MapsLauncher.launchCoordinates(
              position.latitude,
              position.longitude,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Get Directions',
                  style: theme.textTheme.headline6?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.directions_sharp,
                  color: textColor,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
