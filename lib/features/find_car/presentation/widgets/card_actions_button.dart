import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';

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
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              Share.share(shareLink, subject: 'Find my car here!');
            },
            child: Row(
              children: const [
                Icon(
                  Icons.share,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Share'),
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              children: const [
                Icon(
                  Icons.delete,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Delete'),
              ],
            ),
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
