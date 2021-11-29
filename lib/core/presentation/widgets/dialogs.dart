import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 70;
  static const double iconSize = 140;
}

class SuccessDialog extends StatelessWidget {
  final String title, body;
  const SuccessDialog({
    Key? key,
    required this.body,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Dialog(
      bgColor: Theme.of(context).colorScheme.primary,
      icon: Icons.check_circle,
      title: title,
      body: body,
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title, body;
  const ErrorDialog({
    Key? key,
    required this.body,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Dialog(
      bgColor: Colors.red,
      icon: Icons.error_outline,
      title: title,
      body: body,
    );
  }
}

class InfoDialog extends StatelessWidget {
  final String title, body;
  const InfoDialog({
    Key? key,
    required this.body,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Dialog(
      bgColor: Colors.grey,
      icon: Icons.info_outline,
      title: title,
      body: body,
    );
  }
}


class _Dialog extends StatelessWidget {
  final Color bgColor;
  final IconData icon;
  final String title;
  final String body;

  const _Dialog({
    Key? key,
    required this.bgColor,
    required this.icon,
    required this.title,
    required this.body,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(minWidth: Constants.iconSize * 2),
            padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding,
            ),
            margin: const EdgeInsets.only(
              top: Constants.avatarRadius,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: bgColor,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 22,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: Constants.avatarRadius,
              child: Icon(
                icon,
                size: Constants.iconSize,
                color: bgColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
