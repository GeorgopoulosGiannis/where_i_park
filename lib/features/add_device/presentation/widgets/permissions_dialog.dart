import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/add_device/presentation/bloc/add_device_bloc.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 70;
  static const double iconSize = 140;
}

const permissionsMessage =
    '''In order to automatically save location when app is not in use,you need to select "Allow all the time" in location permission.''';

class PermissionsDialog extends StatelessWidget {
  final String title;
  const PermissionsDialog({
    Key? key,
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
      child: DialogContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _Title(text: title),
            const SizedBox(
              height: 15,
            ),
            const _Subtitle(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      permissionsMessage,
      style: TextStyle(
        fontSize: 16,
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
        top: Constants.padding,
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
