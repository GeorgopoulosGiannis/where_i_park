import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/features/find_car/presentation/bloc/find_car_bloc.dart';

import 'delete_location_menu_item.dart';
import 'share_location_menu_item.dart';

class CardActionsButton extends StatelessWidget {
  final CarLocation location;
  const CardActionsButton({
    Key? key,
    required this.location,
  }) : super(key: key);

  String get shareLink =>
      'https://www.google.com/maps/search/?api=1&query=${location.position.latitude},${location.position.longitude}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton(
      color: theme.colorScheme.background,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              Share.share(shareLink, subject: 'Find my car here!');
            },
            child: const ShareLocationMenuItem(),
          ),
          PopupMenuItem(
            onTap: () {
              final bloc = context.read<FindCarBloc>();
              bloc.add(DeleteLocationEvent(bloc.state.location!));
            },
            child: const DeleteLocationMenuItem(),
          ),
        ];
      },
      icon: Icon(
        Icons.more_vert_outlined,
        color: theme.colorScheme.onPrimary,
      ),
    );
  }
}
