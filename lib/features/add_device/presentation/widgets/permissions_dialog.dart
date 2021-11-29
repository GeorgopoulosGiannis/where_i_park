import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:where_i_park/features/add_device/presentation/bloc/add_device_bloc.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 70;
  static const double iconSize = 140;
}

class PermissionsDialog extends StatelessWidget {
  final String title, body;
  const PermissionsDialog({
    Key? key,
    required this.body,
    required this.title,
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
          DialogContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _Title(text: title),
                const SizedBox(
                  height: 15,
                ),
                _Subtitle(body: body),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  children: const [
                    Flexible(
                      flex: 2,
                      child: _OpenPermissionsBtn(),
                    ),
                    Flexible(
                      child: ExitBtn(),
                    ),
                  ],
                )
              ],
            ),
          ),
          const _WarningIcon(),
        ],
      ),
    );
  }
}

class _WarningIcon extends StatelessWidget {
  const _WarningIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: Constants.padding,
      right: Constants.padding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: Constants.iconSize,
            color: Colors.white,
          ),
          Icon(
            Icons.warning_rounded,
            size: Constants.iconSize,
            color: Colors.yellow[500],
          ),
        ],
      ),
    );
  }
}

class ExitBtn extends StatelessWidget {
  const ExitBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
            'Exit',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _OpenPermissionsBtn extends StatelessWidget {
  const _OpenPermissionsBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        child: BlocListener<AddDeviceBloc, AddDeviceState>(
          listener: (context, state) {
            if (state.hasPermissions == true) {
              Navigator.of(context).pop(true);
            }
          },
          child: TextButton(
            onPressed: () {
              context.read<AddDeviceBloc>().add(RequestPermissionsEvent());
            },
            child: const Text(
              'Open permissions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({
    Key? key,
    required this.body,
  }) : super(key: key);

  final String body;

  @override
  Widget build(BuildContext context) {
    return Text(
      body,
      style: const TextStyle(
        fontSize: 14,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class DialogContainer extends StatelessWidget {
  final Widget child;
  const DialogContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: Constants.iconSize * 2,
      ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.padding),
        border: Border.all(
          color: Colors.yellow[500]!,
          width: 8,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Title extends StatelessWidget {
  final String text;
  const _Title({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
